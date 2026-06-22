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

output "aws_role_for_k8s_service_account_dev" {
  description = "This should be used as an input value for demo-app-dev ArgoCD application"
  value       = aws_iam_role.dev_app_secrets.arn
}

output "aws_role_for_k8s_service_account_prod" {
  description = "This should be used as an input value for demo-app-prod ArgoCD application"
  value       = aws_iam_role.prod_app_secrets.arn
}

output "alb_sa_role" {
  description = "This should be used as an input value for aws-load-balancer-controller ArgoCD application"
  value       = aws_iam_role.alb-ingress-controller-role.arn
}

output "vpc_id" {
  description = "This should be used as an input value for aws-load-balancer-controller ArgoCD application"
  value       = module.vpc.vpc_id
}


