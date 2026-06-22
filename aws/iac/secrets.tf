resource "aws_secretsmanager_secret" "dev_env" {
  name = "dev/env"
}

resource "aws_secretsmanager_secret_version" "dev_env" {
  secret_id     = aws_secretsmanager_secret.dev_env.id
  secret_string = var.secret_value_dev
}

resource "aws_secretsmanager_secret" "prod_env" {
  name = "prod/env"
}

resource "aws_secretsmanager_secret_version" "prod_env" {
  secret_id     = aws_secretsmanager_secret.prod_env.id
  secret_string = var.secret_value_prod
}