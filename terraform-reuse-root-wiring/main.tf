module "sg" {
  source = "./modules/sg"
  vpc_id = var.vpc_id

  security_groups = var.security_groups
}

module "ec2" {
  source = "./modules/ec2"

  instances = {
    "web" = {
      ami           = "ami-abc"
      instance_type = "t2.micro"
      subnet_id     = "subnet-123"
      security_groups = [
        module.sg.security_group_ids["web"],
        module.sg.security_group_ids["ssh"]
      ]
    },
    "app" = {
      ami           = "ami-abc"
      instance_type = "t3.micro"
      subnet_id     = "subnet-456"
      security_groups = [
        module.sg.security_group_ids["app"]
      ]
    }
  }
}
