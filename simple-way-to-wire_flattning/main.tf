module "security_group" {
  source          = "./modules/security-group"
  vpc_id          = var.vpc_id
  security_groups = var.security_groups
}
