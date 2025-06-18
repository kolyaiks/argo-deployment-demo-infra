## Once K8S cluster is created, YAML to create resources is applied, we need to change the entry below to point it to
## the correct ALB NAME
resource "aws_route53_record" "domain_names" {
  for_each = toset(var.domain_names)

  allow_overwrite = true
  name            = "${each.key}.${var.hosted_zone_name}"
  records         = ["k8s-lbgroup-c3ecb3cba5-2061125775.us-east-1.elb.amazonaws.com"]
  ttl             = 60
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.public_hosted_zone.zone_id

  #  depends_on = [helm_release.argocd]
}