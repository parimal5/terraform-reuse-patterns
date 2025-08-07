security_groups = {
  web = {
    name        = "web-sg"
    description = "Terraform Web server security group"
  }
  database = {
    name        = "db-sg"
    description = "Terraform Database security group"
  }
}

vpc_id = "vpc-052f35e6575d14ab4"

# Define Ingress Rules separately
ingress_rules = {
  web_http = {
    security_group_key = "web"
    from_port          = 80
    to_port            = 80
    ip_protocol        = "tcp"
    cidr_ipv4          = "0.0.0.0/0"
  }
  web_https = {
    security_group_key = "web"
    from_port          = 443
    to_port            = 443
    ip_protocol        = "tcp"
    cidr_ipv4          = "0.0.0.0/0"
  }
  db_mysql = {
    security_group_key = "database"
    from_port          = 3306
    to_port            = 3306
    ip_protocol        = "tcp"
    cidr_ipv4          = "10.0.0.0/16"
  }
}

# Define Egress Rules separately
egress_rules = {
  web_all_out = {
    security_group_key = "web"
    from_port          = 0
    to_port            = 0
    ip_protocol        = "-1"
    cidr_ipv4          = "0.0.0.0/0"
  }
  db_all_out = {
    security_group_key = "database"
    from_port          = 0
    to_port            = 0
    ip_protocol        = "-1"
    cidr_ipv4          = "0.0.0.0/0"
  }
}
