resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "9.5.14"

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

## App of Apps entrypoint application
resource "kubernetes_manifest" "argocd_bootstrap_app" {
  manifest = {
    apiVersion = "argoproj.io/v1alpha1"
    kind       = "Application"

    metadata = {
      name      = "platform-bootstrap"
      namespace = "argocd"
    }

    spec = {
      project = "default"

      source = {
        repoURL        = "https://github.com/kolyaiks/argo-deployment-demo-gitops.git"
        targetRevision = "main"
        path           = "argocd-apps"
      }

      destination = {
        server    = "https://kubernetes.default.svc"
        namespace = "argocd"
      }

      syncPolicy = {
        automated = {
          prune    = true
          selfHeal = true
        }

        syncOptions = [
          "CreateNamespace=true",
          "PruneLast=true",
          "ApplyOutOfSyncOnly=true"
        ]
      }
    }
  }

  depends_on = [
    helm_release.argocd
  ]
}