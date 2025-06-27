vpc_id = "vpc-0bb1c79de3EXAMPLE"

security_groups = {
  web = {
    description = "Allow HTTP"
  }
  ssh = {
    description = "Allow SSH"
  }
}

instances = {
  web = {
    ami             = "ami-0c55b159cbfafe1f0"
    instance_type   = "t2.micro"
    subnet_id       = "subnet-0bb1c79de3EXAMPLE"
    security_groups = ["web", "ssh"]
  }
  app = {
    ami             = "ami-0c55b159cbfafe1f0"
    instance_type   = "t3.micro"
    subnet_id       = "subnet-0bb1c79de3EXAMPLE"
    security_groups = ["web"]
  }
}
