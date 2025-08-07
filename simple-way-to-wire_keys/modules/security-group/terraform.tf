variable "vpc_id" {
  description = "VPC ID where security groups will be created"
  type        = string
}

variable "security_groups" {
  description = "Map of security group configurations"
  type = map(object({
    name        = string
    description = string
  }))
}

variable "ingress_rules" {
  description = "Map of ingress rules"
  type = map(object({
    security_group_key = string
    from_port          = number
    to_port            = number
    ip_protocol        = string
    cidr_ipv4          = optional(string)
    cidr_ipv6          = optional(string)
  }))
  default = {}
}

variable "egress_rules" {
  description = "Map of egress rules"
  type = map(object({
    security_group_key = string
    from_port          = number
    to_port            = number
    ip_protocol        = string
    cidr_ipv4          = optional(string)
    cidr_ipv6          = optional(string)
  }))
  default = {}
}
