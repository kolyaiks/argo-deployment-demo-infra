resource "aws_security_group" "SG" {
  name   = var.sg_name
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_ports_set
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = var.ingress_cidr_set
    }
  }

  dynamic "egress" {
    for_each = var.egress_ports_set
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = var.egress_cidr_set
    }
  }

  tags = var.tags
}