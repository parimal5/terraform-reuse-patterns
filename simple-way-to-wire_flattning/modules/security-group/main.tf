resource "aws_security_group" "this" {
  for_each = var.security_groups

  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  tags = {
    Name = each.value.name
  }
}

resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each = local.ingress_rules

  security_group_id = aws_security_group.this[each.value.sg_key].id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}

# Step 4: Create egress rules using newer VPC security group egress rule resource
resource "aws_vpc_security_group_egress_rule" "egress" {
  for_each = local.egress_rules

  security_group_id = aws_security_group.this[each.value.sg_key].id
  from_port         = each.value.from_port
  to_port           = each.value.to_port
  ip_protocol       = each.value.protocol
  cidr_ipv4         = each.value.cidr_ipv4
}
