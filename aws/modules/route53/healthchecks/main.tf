resource "aws_route53_health_check" "health_checks" {
  for_each = var.eips_map

  ip_address        = each.value
  type              = "HTTPS"
  port              = 443
  resource_path     = "/healthcheck"
  failure_threshold = "3"
  request_interval  = "30"

  tags = {
    Name = each.key
  }
}