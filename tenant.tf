resource "aci_tenant" "aci_tenant" {
  name = local.tenant.name
}

resource "aci_vrf" "aci_vrf" {
  for_each    = local.vrfs
  tenant_dn   = aci_tenant.aci_tenant.id
  name        = each.value.name
  pc_enf_dir  = contains(keys(each.value), "pc_enf_dir") ? each.value.pc_enf_dir : null
  pc_enf_pref = contains(keys(each.value), "pc_enf_pref") ? each.value.pc_enf_pref : null
}

resource "aci_bridge_domain" "aci_bds" {
  for_each           = local.bridge_domains
  tenant_dn          = aci_tenant.aci_tenant.id
  name               = each.value.name
  relation_fv_rs_ctx = aci_vrf.aci_vrf[each.value.vrf].id
  arp_flood          = contains(keys(each.value), "arp_flood") ? each.value.arp_flood : null
}

resource "aci_subnet" "aci_subnets" {
  for_each  = local.subnets
  parent_dn = aci_bridge_domain.aci_bds[each.value.bd].id
  ip        = each.value.ip
  scope     = contains(keys(each.value), "scope") ? each.value.scope : null
  # description = each.value.description
}

resource "aci_application_profile" "aci_app_profile" {
  for_each  = local.app_profiles
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_application_epg" "aci_epgs" {
  for_each               = local.epgs
  application_profile_dn = aci_application_profile.aci_app_profile[each.value.apName].id
  name                   = each.value.name
  relation_fv_rs_bd      = aci_bridge_domain.aci_bds[each.value.bdName].id
}

resource "aci_filter" "aci_filters" {
  for_each  = local.filters
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_filter_entry" "aci_filter_entries" {
  for_each    = local.filter_entries
  filter_dn   = aci_filter.aci_filters[each.value.filter_name].id
  name        = each.value.name
  d_from_port = each.value.dest_from_port
  d_to_port   = each.value.dest_to_port
  ether_t     = each.value.ether_type
  prot        = each.value.protocol
}

resource "aci_contract" "aci_contracts" {
  for_each  = local.contracts
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_contract_subject" "aci_contract_subjects" {
  for_each    = local.contracts
  contract_dn = aci_contract.aci_contracts[each.value.name].id
  name        = each.value.subject
  # relation_vz_rs_subj_filt_att  = [aci_filter.aci_filters[each.value.filter].id]
  relation_vz_rs_subj_filt_att = [for filt in each.value.filter : aci_filter.aci_filters[filt].id]
}

resource "aci_epg_to_contract" "aci_epg_contract" {
  for_each           = local.contract_bindings
  application_epg_dn = aci_application_epg.aci_epgs[each.value.epg].id
  contract_dn        = aci_contract.aci_contracts[each.value.contract].id
  contract_type      = each.value.contract_type
}

resource "aci_epg_to_domain" "aci_epg_domain" {
  for_each           = local.epgs
  application_epg_dn = aci_application_epg.aci_epgs[each.value.name].id
  tdn                = local.aci_domain
}