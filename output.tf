output "tenant" {
  value = resource.aci_tenant.aci_tenant.id
}

output "vrf" {
  value = [for item in resource.aci_vrf.aci_vrf : item.id]
}

output "bd" {
  value = [for item in resource.aci_bridge_domain.aci_bds : item.id]
}

output "subnet" {
  value = [for item in resource.aci_subnet.aci_subnets : item.id]
}

output "ap" {
  value = [for item in resource.aci_application_profile.aci_app_profile : item.id]
}

output "epg" {
  value = [for item in resource.aci_application_epg.aci_epgs : item.id]
}

output "filter" {
  value = [for item in resource.aci_filter.aci_filters : item.id]
}

output "entry" {
  value = [for item in resource.aci_filter_entry.aci_filter_entries : item.id]
}

output "contract" {
  value = [for item in resource.aci_contract.aci_contracts : item.id]
}

output "contract_subject" {
  value = [for item in resource.aci_contract_subject.aci_contract_subjects : item.id]
}

output "epg_contract" {
  value = [for item in aci_epg_to_contract.aci_epg_contract : item.id]
}

output "epg_domain" {
  value = [for item in aci_epg_to_domain.aci_epg_domain : item.id]
}