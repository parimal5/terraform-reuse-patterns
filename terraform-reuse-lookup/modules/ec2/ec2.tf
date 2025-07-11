resource "aws_instance" "this" {
  for_each = var.instances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  subnet_id     = each.value.subnet_id

  vpc_security_group_ids = [
    for sg_name in each.value.security_groups :
    var.sg_id_map[sg_name]
  ]
}
