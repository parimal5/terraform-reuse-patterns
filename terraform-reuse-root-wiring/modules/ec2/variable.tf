variable "instances" {
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_id       = string
    security_groups = list(string)
  }))
}
