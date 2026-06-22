##### Installing the charts that will allow us to map secrets to k8s objects ##########

# resource "helm_release" "secrets_csi_driver" {
#   name = "secrets-csi-driver"
#
#   repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
#   chart      = "secrets-store-csi-driver"
#   namespace  = "kube-system"
#   version    = "1.5.6"
#
#   ## to allow using secrets as env variable
#   set = [
#     {
#       name = "syncSecret.enabled"
#       value = true
#     }
#   ]
#
#   depends_on = [module.eks]
# }

# resource "helm_release" "secrets_csi_driver_aws_provider" {
#   name = "secrets-store-csi-driver-provider-aws"
#
#   repository = "https://aws.github.io/secrets-store-csi-driver-provider-aws"
#   chart      = "secrets-store-csi-driver-provider-aws"
#   namespace  = "kube-system"
#   version    = "2.2.1"
#
#   # depends_on = [helm_release.secrets_csi_driver]
# }

##### Creating the namespace-specific role that will be mapped to the service account in EKS | DEV ##########

# trust policy that will be used by the role that is going to be tied to the k8s service account
data "aws_iam_policy_document" "dev_app_secrets" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:dev:app-sa"] ## update to namespace:service account name
      variable = "${replace(module.eks.oidc_provider, "https://", "")}:sub"
    }

    principals {
      identifiers = [module.eks.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

# creating the role that will be used by service account
resource "aws_iam_role" "dev_app_secrets" {
  name               = "${module.eks.cluster_name}-dev-app-secrets"
  assume_role_policy = data.aws_iam_policy_document.dev_app_secrets.json
}

resource "aws_iam_policy" "dev_app_secrets" {
  name = "${module.eks.cluster_name}-dev-app-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.dev_env.arn
      }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "dev_app_secrets" {
  policy_arn = aws_iam_policy.dev_app_secrets.arn
  role       = aws_iam_role.dev_app_secrets.name
}

##### Creating the namespace-specific role that will be mapped to the service account in EKS | PROD ##########

# trust policy that will be used by the role that is going to be tied to the k8s service account
data "aws_iam_policy_document" "prod_app_secrets" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      values   = ["system:serviceaccount:prod:app-sa"] ## update to namespace:service account name
      variable = "${replace(module.eks.oidc_provider, "https://", "")}:sub"
    }

    principals {
      identifiers = [module.eks.oidc_provider_arn]
      type        = "Federated"
    }
  }
}

# creating the role that will be used by service account
resource "aws_iam_role" "prod_app_secrets" {
  name               = "${module.eks.cluster_name}-prod-app-secrets"
  assume_role_policy = data.aws_iam_policy_document.prod_app_secrets.json
}

resource "aws_iam_policy" "prod_app_secrets" {
  name = "${module.eks.cluster_name}-prod-app-secrets"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Resource = aws_secretsmanager_secret.prod_env.arn
      }

    ]
  })
}

resource "aws_iam_role_policy_attachment" "prod_app_secrets" {
  policy_arn = aws_iam_policy.prod_app_secrets.arn
  role       = aws_iam_role.prod_app_secrets.name
}
