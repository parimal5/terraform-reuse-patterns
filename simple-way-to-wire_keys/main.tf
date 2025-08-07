module "mySG" {
  source = "./modules/security-group"

  vpc_id          = "vpc-052f35e6575d14ab4"
  security_groups = var.security_groups
  ingress_rules   = var.ingress_rules
  egress_rules    = var.egress_rules
}
