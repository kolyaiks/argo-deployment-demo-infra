output "public_subents" {
  value = module.vpc.public_subnets
}

output "acm_cert" {
  value = aws_acm_certificate.alb_cert.arn
}

output "kubernetes_endpoint" {
  value = module.eks.cluster_endpoint
}

#output "argocd_lb" {
#  value = helm_release.argocd.argocd_server_load_balancer
#}

