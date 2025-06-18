resource "aws_instance" "ec2s" {
  count = length(var.ec2_instances_list)

  #  ami                    = data.aws_ami.latest_amazon_linux_2.id
  ami                    = "ami-0be2609ba883822ec"
  instance_type          = var.ec2_instance_type
  iam_instance_profile   = var.ec2_instance_profile
  vpc_security_group_ids = var.security_groups_set
  subnet_id              = (count.index + 1) % 2 == 0 ? var.public_subnets_list[0] : var.public_subnets_list[1]
  tags = {
    Name = format("%s_env_%s", var.ec2_instances_list[count.index], var.env)
  }
  key_name = var.key_name
  user_data = templatefile("${path.module}/userData.tpl", {
    env                 = split("_", var.ec2_instances_list[count.index])[0],
    current_aws_account = data.aws_caller_identity.current_aws_account.id,
    current_region      = var.region,
    name_of_application = var.name_of_application,
    bucket_name         = var.bucket_name
  })
  lifecycle {
    create_before_destroy = true
  }
}
