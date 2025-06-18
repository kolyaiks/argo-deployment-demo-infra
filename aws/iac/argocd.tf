resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "8.0.12"

  namespace = "argocd"

  create_namespace = true

  #  set {
  #    name  = "server.service.type"
  #    value = "LoadBalancer"
  #  }
  #
  #  set {
  #    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
  #    value = "nlb"
  #  }

  depends_on = [module.eks, helm_release.aws-load-balancer-controller]
}