variable "tenant_name" {
  type        = string
  description = "The name of tenant"
}

variable "vrfs" {
  type        = map(any)
  description = "VRFs"
  default     = {}
}

variable "bridge_domains" {
  type        = map(any)
  description = "Bridge domains"
  default     = {}
}

variable "subnets" {
  type        = map(any)
  description = "Subnets of Bridge domains"
  default     = {}
}

variable "app_profiles" {
  type        = map(any)
  description = "Application profiles"
  default     = {}
}

variable "epgs" {
  type        = map(any)
  description = "Endpoint groups"
  default     = {}
}

variable "filters" {
  type        = map(any)
  description = "Filters"
  default     = {}
}

variable "filter_entries" {
  type        = map(any)
  description = "Filter entries"
  default     = {}
}

variable "contracts" {
  type        = map(any)
  description = "Contracts"
  default     = {}
}

variable "contract_bindings" {
  type        = map(any)
  description = "Contract bindings"
  default     = {}
}

variable "aci_domain" {
  type        = string
  description = "Domain"
  default     = null
}