variable "tenant" {
  type        = string
  description = "(Required) The name of tenant"
}
variable "vrfs" {
  type    = map(any)
  description = "(Optional) VRFs"
  default = {}
}
variable "bridge_domains" {
  type    = map(any)
  description = "(Optional) Bridge domains"
  default = {}
}
variable "subnets" {
  type    = map(any)
  description = "(Optional) Subnets of Bridge domains"
  default = {}
}
variable "app_profiles" {
  type    = map(any)
  description = "(Optional) Application profiles"
  default = {}
}
variable "epgs" {
  type    = map(any)
  description = "(Optional) Endpoint groups"
  default = {}
}
variable "filters" {
  type    = map(any)
  description = "(Optional) Filters"
  default = {}
}
variable "filter_entries" {
  type    = map(any)
  description = "(Optional) Filter entries"
  default = {}
}
variable "contracts" {
  type    = map(any)
  description = "(Optional) Contracts"
  default = {}
}
variable "contract_bindings" {
  type    = map(any)
  description = "(Optional) Contract bindings"
  default = {}
}
variable "aci_domain" {
  type    = string
  description = "(Optional) Domain"
  default = null
}