variable "vpc_id" {
  type = string
}


variable "security_groups" {
  type = map(object({
    description = string
  }))
}


variable "instances" {
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_id       = string
    security_groups = list(string)
  }))
}

