# terraform-aci-tenant

Manages ACI Tenant and children

- Tenant
- VRFs
- Bridge domains and subnets
- Application profiles
- EPGs
- Filter and Filter entries
- Contracts
- Contract bindings

## How to use

### Example 1

```hcl
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.3.0"

  tenant = {
    name = "tenant1"
  }
}
```

### Example 2

```hcl
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.3.0"

  tenant = {
    name        = "tenant2",
    description = "TEST"          # optional
  }

  vrfs = {
    vrf0 = { 
        name = "TEST1-VRF" 
    }
  }

  bridge_domains = {
    bd1 = { 
        name = "TEST1-BD", 
        vrf = "TEST1-VRF"
    }
  }

  subnets = {
    subn1 = { 
        bd = "TEST1-BD", 
        ip = "10.225.3.1/24", 
        scope = ["public"] 
    }
  }

  app_profiles = {
    ap1 = { 
        name = "TEST-AP" 
    }
  }

  epgs = {
    epg1 = { 
        name      = "TEST1-EPG", 
        bdName    = "TEST1-BD", 
        apName    = "TEST-AP",
        aciDomain = "uni/phys-TEST" 
    }
  }
}
```

### Example 3
```hcl
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.3.0"

  tenant = {
    name = "tenant3"
  }

  vrfs = {
    vrf0 = { name = "TEST1-VRF" },
    vrf1 = { name = "TEST2-VRF" }
  }

  bridge_domains = {
    bd1 = { name = "TEST1-BD", vrf = "TEST1-VRF" },
    bd2 = { name = "TEST2-BD", vrf = "TEST1-VRF" },
    bd3 = { name = "TEST3-BD", vrf = "TEST2-VRF" },
    bd4 = { name = "TEST4-BD", vrf = "TEST2-VRF" }
  }

  subnets = {
    subn1 = { bd = "TEST1-BD", ip = "10.225.3.1/24", scope = ["public"] },
    subn2 = { bd = "TEST2-BD", ip = "10.225.4.1/24", scope = ["public"] },
    subn3 = { bd = "TEST3-BD", ip = "10.225.5.1/24", scope = ["public"] },
    subn4 = { bd = "TEST4-BD", ip = "10.225.6.1/24", scope = ["public"] }
  }

  app_profiles = {
    ap1 = { name = "TEST-AP" }
  }

  epgs = {
    epg1 = { name = "TEST1-EPG", bdName = "TEST1-BD", apName = "TEST-AP", aciDomain = "uni/phys-TEST" },
    epg2 = { name = "TEST2-EPG", bdName = "TEST2-BD", apName = "TEST-AP", aciDomain = "uni/phys-TEST" },
    epg3 = { name = "TEST3-EPG", bdName = "TEST3-BD", apName = "TEST-AP", aciDomain = "uni/phys-TEST" },
    epg4 = { name = "TEST4-EPG", bdName = "TEST4-BD", apName = "TEST-AP", aciDomain = "uni/phys-TEST" },
    epg5 = { name = "TEST5-EPG", bdName = "TEST4-BD", apName = "TEST-AP", aciDomain = "uni/phys-TEST" }
  }

  filters = {
    any = { name = "any" },
    ssh = { name = "ssh" },
    web = { name = "web" }
  }

  filter_entries = {
    any  = { filter_name = "any", name = "any", dest_from_port = "unspecified", dest_to_port = "unspecified", ether_type = "unspecified", protocol = "unspecified" }, # unspecified icmp igmp tcp egp igp udp icmpv6 eigrp ospfigp pim l2tp           
    ssh  = { filter_name = "ssh", name = "ssh", dest_from_port = "22", dest_to_port = "22", ether_type = "ipv4", protocol = "tcp" },
    web1 = { filter_name = "web", name = "http", dest_from_port = "80", dest_to_port = "80", ether_type = "ipv4", protocol = "tcp" },
    web2 = { filter_name = "web", name = "https", dest_from_port = "443", dest_to_port = "443", ether_type = "ipv4", protocol = "tcp" }
  }

  contracts = {
    any = { name = "any", filter = ["any"] },
    ssh = { name = "ssh", filter = ["ssh"] },
    web = { name = "http", filter = ["http", "https"] }
  }

  contract_bindings = {
    test1-epg-prov1 = { epg = "TEST1-EPG", contract_type = "provider", contract = "any" },
    test2-epg-prov1 = { epg = "TEST2-EPG", contract_type = "provider", contract = "ssh" },
    test3-epg-prov1 = { epg = "TEST3-EPG", contract_type = "provider", contract = "ssh" },
    test4-epg-prov1 = { epg = "TEST4-EPG", contract_type = "provider", contract = "ssh" },
    test5-epg-prov1 = { epg = "TEST5-EPG", contract_type = "provider", contract = "ssh" },
    test5-epg-prov2 = { epg = "TEST5-EPG", contract_type = "provider", contract = "ssh" },
    test1-epg-cons1 = { epg = "TEST1-EPG", contract_type = "consumer", contract = "any" },
    test2-epg-cons1 = { epg = "TEST2-EPG", contract_type = "consumer", contract = "any" },
    test3-epg-cons1 = { epg = "TEST3-EPG", contract_type = "consumer", contract = "any" },
    test4-epg-cons1 = { epg = "TEST4-EPG", contract_type = "consumer", contract = "any" },
    test5-epg-cons1 = { epg = "TEST5-EPG", contract_type = "consumer", contract = "any" }
  }
}
```
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.4 |
| <a name="requirement_aci"></a> [aci](#requirement\_aci) | >= 2.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aci"></a> [aci](#provider\_aci) | >= 2.1.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ACI Tenant | <pre>map(object({<br> name        = string,<br> description = optional(string)<br>}))</pre> | n/a | yes |
| <a name="input_vrfs"></a> [vrfs](#input\_vrfs) | VRFs | <pre>map(object({<br> name = string<br>}))</pre> | `{}` | no |
| <a name="input_bridge_domains"></a> [bridge_domains](#input\_bridge_domains) | Bridge domains | <pre>map(object({<br> name = string,<br> vrf  = string<br>}))</pre> | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Subnets | <pre>map(object({<br> bd    = string,<br> ip    = string,<br> scope = list(string)<br>}))</pre> | `{}` | no |
| <a name="input_app_profiles"></a> [app_profile](#input\_app_profiles) | Application profiles |  <pre>map(object({<br> name = string<br>}))</pre> | `{}` | no |
| <a name="input_epgs"></a> [epgs](#input\_epgs) | EPGs |  <pre>map(object({<br> name      = string,<br> bdName    = string,<br> apName    = string,<br> aciDomain = string<br>}))</pre> | `{}` | no |
| <a name="input_filters"></a> [filters](#input\_filters) | Filters |  <pre>map(object({<br> name = string<br>}))</pre> | `{}` | no |
| <a name="input_filter_entries"></a> [filter_entries](#input\_filter_entries) | Filter entries |  <pre>map(object({<br> name           = string,<br> filter_name    = string,<br> dest_from_port = string,<br> dest_to_port   = string,<br> ether_type     = string,<br> protocol       = string<br>}))</pre> | `{}` | no |
| <a name="input_contracts"></a> [contracts](#input\_contracts) | Contracts |  <pre>map(object({<br> name   = string,<br> filter = list(string)<br>}))</pre> | `{}` | no |
| <a name="input_contract_bindings"></a> [contract_bindings](#input\_contract_bindings) | Contract bindings |  <pre>map(object({<br> epg           = string,<br> contract_type = string,<br> contract      = string<br>}))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_tenant"></a> [tenant](#output\_tenant) | ID of Tenant |
| <a name="output_vrf"></a> [vrf](#output\_vrf) | IDs of VRF |
| <a name="output_bd"></a> [bd](#output\_bd) | IDs of Bridge domain |
| <a name="output_subnet"></a> [subnet](#output\_subnet) | IDs of Subnet |
| <a name="output_ap"></a> [ap](#output\_ap) | IDs of Application profiles  |
| <a name="output_epg"></a> [epg](#output\_epg) | IDs of EPG |
| <a name="output_filter"></a> [filter](#output\_filter) | IDs of Filter  |
| <a name="output_entry"></a> [entry](#output\_entry) | IDs of Filter entry |
| <a name="output_contract"></a> [contract](#output\_contract) | IDs of Contract |
| <a name="output_epg_contract"></a> [epg_contract](#output\_epg_contract) | IDs of Contract binding |
| <a name="output_domain"></a> [domain](#output\_domain) | IDs of ACI Domain |

## Resources

| Name | Type |
|------|------|
| [aci_tenant](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/tenant) | resource |
| [aci_vrf](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/vrf) | resource |
| [aci_bridge_domain](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/bridge_domain) | resource |
| [aci_subnet](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/subnet) | resource |
| [aci_application_profile](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/application_profile) | resource |
| [aci_application_epg](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/application_epg) | resource |
| [aci_filter](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/filter) | resource |
| [aci_filter_entry](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/filter_entry) | resource |
| [aci_contract](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/contract) | resource |
| [aci_epg_to_contract](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/epg_to_contract) | resource |
| [aci_epg_to_domain](https://registry.terraform.io/providers/CiscoDevNet/aci/latest/docs/resources/epg_to_domain) | resource |
