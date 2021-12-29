terraform {
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "0.7.1"
    }
  }
  required_version = ">=0.13.4"
}

locals {
  tenant            = contains(keys(var.tenant), "tenant") ? var.tenant.tenant : {}
  vrfs              = contains(keys(var.tenant), "vrfs") ? var.tenant.vrfs : {}
  bridge_domains    = contains(keys(var.tenant), "bridge_domains") ? var.tenant.bridge_domains : {}
  subnets           = contains(keys(var.tenant), "subnets") ? var.tenant.subnets : {}
  app_profiles      = contains(keys(var.tenant), "app_profiles") ? var.tenant.app_profiles : {}
  epgs              = contains(keys(var.tenant), "epgs") ? var.tenant.epgs : {}
  filters           = contains(keys(var.tenant), "filters") ? var.tenant.filters : {}
  filter_entries    = contains(keys(var.tenant), "filter_entries") ? var.tenant.filter_entries : {}
  contracts         = contains(keys(var.tenant), "contracts") ? var.tenant.contracts : {}
  epg_static_paths  = contains(keys(var.tenant), "epg_static_paths") ? var.tenant.epg_static_paths : {} # need to be exclusive from variable epg_static_paths
  contract_bindings = contains(keys(var.tenant), "contract_bindings") ? var.tenant.contract_bindings : {}
  aci_domain        = contains(keys(var.tenant), "aci_domain") ? var.tenant.aci_domain : null
}