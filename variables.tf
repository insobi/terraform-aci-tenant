variable "aci_url" {
  type = string
}

variable "aci_user" {
  type = string
}

variable "aci_pw" {
  type      = string
  sensitive = true
}

variable "tenant" {}

variable "epg_static_paths" {
  type    = map(any)
  default = {}
}