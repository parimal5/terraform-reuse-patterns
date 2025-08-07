locals {
  # Flatten ingress rules: Convert nested structure to flat map
  # Each CIDR block needs its own rule resource
  ingress_rules = {
    for rule_key, rule_data in flatten([
      for sg_key, sg_config in var.security_groups : [
        for rule_index, rule in sg_config.ingress_rules : [
          for cidr_index, cidr_block in rule.cidr_blocks : {
            key       = "${sg_key}-ingress-${rule_index}-${cidr_index}"
            sg_key    = sg_key
            from_port = rule.from_port
            to_port   = rule.to_port
            protocol  = rule.protocol
            cidr_ipv4 = cidr_block
          }
        ]
      ]
    ]) : rule_data.key => rule_data
  }

  # Flatten egress rules: Same logic as above
  egress_rules = {
    for rule_key, rule_data in flatten([
      for sg_key, sg_config in var.security_groups : [
        for rule_index, rule in sg_config.egress_rules : [
          for cidr_index, cidr_block in rule.cidr_blocks : {
            key       = "${sg_key}-egress-${rule_index}-${cidr_index}"
            sg_key    = sg_key
            from_port = rule.from_port
            to_port   = rule.to_port
            protocol  = rule.protocol
            cidr_ipv4 = cidr_block
          }
        ]
      ]
    ]) : rule_data.key => rule_data
  }
}
