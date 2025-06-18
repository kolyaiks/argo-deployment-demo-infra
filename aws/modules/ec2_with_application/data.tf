data "aws_ami" "latest_amazon_linux_2" {
  owners = [
  "137112412989"]
  most_recent = true
  filter {
    name = "name"
    values = [
    "amzn2-ami-hvm-2.0.*-x86_64-gp2"]
  }
}

data "aws_caller_identity" "current_aws_account" {}
