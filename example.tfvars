tenants = {

  # TENANT1 = {

  #   tenant = { 
  #     name = "DEMO" 
  #   }

  #   vrfs = {
  #     DEMO-VRF = {
  #       name = "DEMO-VRF"
  #     }
  #   }

  #   bridge_domains = {
  #     DEMO-V1-BD = { name = "DEMO-V1-BD", vrf = "DEMO-VRF" }
  #     DEMO-V2-BD = { name = "DEMO-V2-BD", vrf = "DEMO-VRF" }
  #     DEMO-V3-BD = { name = "DEMO-V3-BD", vrf = "DEMO-VRF" }
  #     DEMO-V4-BD = { name = "DEMO-V4-BD", vrf = "DEMO-VRF" }
  #     DEMO-V5-BD = { name = "DEMO-V5-BD", vrf = "DEMO-VRF" }
  #   }

  #   subnets = {
  #     DEMO-V1-Subn = { bd = "DEMO-V1-BD", ip = "10.225.3.1/24", scope = ["public"] }
  #     DEMO-V2-Subn = { bd = "DEMO-V2-BD", ip = "10.225.4.1/24", scope = ["public"] }
  #     DEMO-V3-Subn = { bd = "DEMO-V3-BD", ip = "10.225.5.1/24", scope = ["public"] }
  #     DEMO-V4-Subn = { bd = "DEMO-V4-BD", ip = "10.225.6.1/24", scope = ["public"] }
  #     DEMO-V5-Subn = { bd = "DEMO-V5-BD", ip = "10.225.7.1/24", scope = ["public"] }
  #   }

  #   app_profiles = {
  #     DEMO-ANP = { name = "DEMO-ANP" }
  #   }

  #   epgs = {
  #     DEMO-V1-EPG = { name = "DEMO-V1-EPG", bdName = "DEMO-V1-BD", apName = "DEMO-ANP" }
  #     DEMO-V2-EPG = { name = "DEMO-V2-EPG", bdName = "DEMO-V2-BD", apName = "DEMO-ANP" }
  #     DEMO-V3-EPG = { name = "DEMO-V3-EPG", bdName = "DEMO-V3-BD", apName = "DEMO-ANP" }
  #     DEMO-V4-EPG = { name = "DEMO-V4-EPG", bdName = "DEMO-V4-BD", apName = "DEMO-ANP" }
  #     DEMO-V5-EPG = { name = "DEMO-V5-EPG", bdName = "DEMO-V5-BD", apName = "DEMO-ANP" }
  #   }

  #   filters = {
  #     ANY_Filt = {
  #       name = "ANY_Filt"
  #     }
  #   }

  #   filter_subjects = {
  #     ANY_Filt_subject = {
  #       name = "ANY_Filt"
  #     }
  #   }

  #   filter_entries = {
  #     any = {
  #       filter_name    = "ANY_Filt"
  #       name           = "any"
  #       dest_from_port = "unspecified"
  #       dest_to_port   = "unspecified"
  #       ether_type     = "unspecified"
  #       protocol       = "unspecified" # unspecified icmp igmp tcp egp igp udp icmpv6 eigrp ospfigp pim l2tp           
  #     }
  #   }

  #   contracts = {
  #     ANY_CT = {
  #       name    = "ANY_CT"
  #       subject = "any"
  #       filter  = ["ANY_Filt"]
  #     }
  #   }

  #   contract_bindings = {
  #     DEMO-V1-EPG_1 = {
  #       epg           = "DEMO-V1-EPG"
  #       contract      = "ANY_CT"
  #       contract_type = "provider"
  #     }
  #     DEMO-V1-EPG_2 = {
  #       epg           = "DEMO-V1-EPG"
  #       contract      = "ANY_CT"
  #       contract_type = "consumer"
  #     }
  #   }
  #   epg_static_paths = {}

  #   aci_domain = "uni/phys-TEST"
  # },

  # TENANT2 = {
  #   ...
  # }
}