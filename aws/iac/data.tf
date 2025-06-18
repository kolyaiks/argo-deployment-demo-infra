data "aws_availability_zones" "azs" {}

data "aws_route53_zone" "public_hosted_zone" {
  name = var.hosted_zone_name

  private_zone = false
}

