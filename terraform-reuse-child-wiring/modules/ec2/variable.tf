variable "instances" {
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_id       = string
    security_groups = list(string)
  }))
}

variable "security_groups" {
  description = "The full SG config passed down from root (creates dependency)"
  type = map(object({
    description = string
  }))
}

variable "sg_id_map" {
  description = "Map of SG name => SG ID (from SG module output)"
  type        = map(string)
}
