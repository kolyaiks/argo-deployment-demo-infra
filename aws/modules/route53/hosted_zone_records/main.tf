#===========Rote53 Hosted Zone Records=====================

resource "aws_route53_record" "hosted_zone_records" {
  for_each = var.healthchecks_map

  zone_id = data.aws_route53_zone.hosted_zone.id
  name    = format("%sapi.%s", split("_", each.key)[0], data.aws_route53_zone.hosted_zone.name)
  type    = "A"
  ttl     = 60
  failover_routing_policy {
    type = upper(split("_", each.key)[1])
  }
  health_check_id = each.value.id

  records = [
  each.value.ip_address]

  set_identifier = each.key
}