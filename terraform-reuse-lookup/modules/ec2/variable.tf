variable "instances" {
  type = map(object({
    ami             = string
    instance_type   = string
    subnet_id       = string
    security_groups = list(string) # just names like ["web", "ssh"]
  }))
}

variable "sg_id_map" {
  description = "Map of SG name → ID passed from SG module"
  type        = map(string)
}
