
module "sg" {
  source = "./modules/sg"

  vpc_id          = var.vpc_id
  security_groups = var.security_groups
}

module "ec2" {
  source = "./modules/ec2"

  instances = var.instances
  sg_id_map = module.sg.security_group_ids
}
