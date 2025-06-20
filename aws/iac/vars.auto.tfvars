region                               = "us-east-1"
hosted_zone_name                     = "niks.cloud"
company_name                         = "argo-deployment-demo"
cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"] //TODO: put your CIDR here if you want to limit the scope of allowed IPs for the k8s endpoint
domain_names                         = ["dev-app","prod-app"]
