resource "aws_eip" "eips" {
  for_each = var.ec2s

  instance = each.value
  vpc      = true
  tags = {
    Name = each.key
  }
}