variable "secret" {
  type = map(any)
  default = {
    url  = ""
    user = ""
    pw   = ""
  }
  sensitive = true
}

variable "tenant" {}

variable "epg_static_paths" {
  type    = map(any)
  default = {}
}