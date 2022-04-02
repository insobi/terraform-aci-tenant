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

# How to use

### Example 1

```
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.1.8"

  tenant_name = "tenant1"
}
```

### Example 2

```
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.1.8"

  tenant_name = "tenant2"

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
        name = "TEST1-EPG", 
        bdName = "TEST1-BD", 
        apName = "TEST-AP" 
    }
  }
}
```

### Example 3
```
module "aci_tenants" {
  source  = "insobi/tenant/aci"
  version = "0.1.8"

  tenant_name = "tenant3"

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
    epg1 = { name = "TEST1-EPG", bdName = "TEST1-BD", apName = "TEST-AP" },
    epg2 = { name = "TEST2-EPG", bdName = "TEST2-BD", apName = "TEST-AP" },
    epg3 = { name = "TEST3-EPG", bdName = "TEST3-BD", apName = "TEST-AP" },
    epg4 = { name = "TEST4-EPG", bdName = "TEST4-BD", apName = "TEST-AP" },
    epg5 = { name = "TEST5-EPG", bdName = "TEST4-BD", apName = "TEST-AP" }
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

  aci_domain = "uni/phys-TEST"
}
```
