resource "aws_security_group" "this" {
  for_each = var.security_groups

  description = each.value.description
  vpc_id      = var.vpc_id
}
