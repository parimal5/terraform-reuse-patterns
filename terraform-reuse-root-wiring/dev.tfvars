
vpc_id = "10.0.0.0/16"

security_groups = {
  web = {
    name        = "web-sg"
    description = "Allow web traffic"
  }
  ssh = {
    name        = "ssh-sg"
    description = "Allow SSH"
  }
  app = {
    name        = "app-sg"
    description = "Allow SSH"
  }
}

