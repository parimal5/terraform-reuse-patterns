locals {
  instance_sg_ids = {
    for inst_name, inst_data in var.instances :
    inst_name => [
      for sg_name in inst_data.security_groups :
      var.sg_id_map[sg_name]
    ]
  }
}

resource "aws_instance" "this" {
  for_each = var.instances

  ami                    = each.value.ami
  instance_type          = each.value.instance_type
  subnet_id              = each.value.subnet_id
  vpc_security_group_ids = local.instance_sg_ids[each.key]
}
