resource "aci_tenant" "aci_tenant" {
  name        = var.tenant.name
  description = contains(keys(var.tenant), "description") ? var.tenant.description : null
}

resource "aci_vrf" "aci_vrf" {
  for_each    = var.vrfs
  tenant_dn   = aci_tenant.aci_tenant.id
  name        = each.value.name
  pc_enf_dir  = contains(keys(each.value), "pc_enf_dir") ? each.value.pc_enf_dir : null
  pc_enf_pref = contains(keys(each.value), "pc_enf_pref") ? each.value.pc_enf_pref : null
}

resource "aci_bridge_domain" "aci_bds" {
  for_each           = var.bridge_domains
  tenant_dn          = aci_tenant.aci_tenant.id
  name               = each.value.name
  relation_fv_rs_ctx = element([for item in aci_vrf.aci_vrf : item.id if item.name == each.value.vrf], 0)
  arp_flood          = contains(keys(each.value), "arp_flood") ? each.value.arp_flood : null
  unicast_route      = contains(keys(each.value), "unicast_route") ? each.value.unicast_route : null
}

resource "aci_subnet" "aci_subnets" {
  for_each  = var.subnets
  parent_dn = element([for item in aci_bridge_domain.aci_bds : item.id if item.name == each.value.bd], 0)
  ip        = each.value.ip
  scope     = contains(keys(each.value), "scope") ? each.value.scope : null
  # description = each.value.description
}

resource "aci_application_profile" "aci_app_profile" {
  for_each  = var.app_profiles
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_application_epg" "aci_epgs" {
  for_each               = var.epgs
  application_profile_dn = element([for item in aci_application_profile.aci_app_profile : item.id if item.name == each.value.apName], 0)
  name                   = each.value.name
  relation_fv_rs_bd      = element([for item in aci_bridge_domain.aci_bds : item.id if item.name == each.value.bdName], 0)
}

resource "aci_filter" "aci_filters" {
  for_each  = var.filters
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_filter_entry" "aci_filter_entries" {
  for_each    = var.filter_entries
  filter_dn   = element([for item in aci_filter.aci_filters : item.id if item.name == each.value.filter_name], 0)
  name        = each.value.name
  d_from_port = each.value.dest_from_port
  d_to_port   = each.value.dest_to_port
  ether_t     = each.value.ether_type
  prot        = each.value.protocol
}

resource "aci_contract" "aci_contracts" {
  for_each  = var.contracts
  tenant_dn = aci_tenant.aci_tenant.id
  name      = each.value.name
}

resource "aci_epg_to_contract" "aci_epg_contract" {
  for_each           = var.contract_bindings
  application_epg_dn = element([for item in aci_application_epg.aci_epgs : item.id if item.name == each.value.epg], 0)
  contract_dn        = element([for item in aci_contract.aci_contracts : item.id if item.name == each.value.contract], 0)
  contract_type      = each.value.contract_type
}

resource "aci_epg_to_domain" "aci_epg_domain" {
  for_each           = var.epgs
  application_epg_dn = element([for item in aci_application_epg.aci_epgs : item.id if item.name == each.value.name], 0)
  tdn                = each.value.aciDomain
}