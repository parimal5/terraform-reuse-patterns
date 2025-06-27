variable "security_groups" {
  type = map(object({
    description = string
  }))
}

variable "vpc_id" {
  type = string
}
