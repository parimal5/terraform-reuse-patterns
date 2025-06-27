variable "security_groups" {
  type = map(object({
    name        = string
    description = string
  }))
}

variable "vpc_id" {
  type = string
}
