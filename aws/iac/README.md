## Order of apply:

### Setting up the base AWS infrastructure

1. `aws/iac` folder - `terraform apply --auto-approve` to create base infrastructure; 
2. `aws eks update-kubeconfig --region us-east-1 --name argo-deployment-demo-cluster` - setting up the context for a new cluster, name may vary

### Setting up ArgoCD and applications

1. `k8s-yaml/app/argo-deployment-demo-app/base/ingress.yaml` - setting up the public subnets deployed on the first step and ARN for cert
2. `kubectl port-forward svc/argocd-server -n argocd 8080:80` - proxy local port 8080 to argocd's ui pod
3. `kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd` - getting the secret we'll need to an `admin` user, it's in base64, so we'll need to decrypt
4. `https://localhost:8080/` - in browser getting the ArgoCD UI
5. `https://localhost:8080/settings/repos` - we need to set a repo with our yaml configuration; user your github username and personal access token that allows working with the IAC repo, could be created [here](https://github.com/settings/personal-access-tokens) 
6. `https://localhost:8080/settings/projects` - if we want to be specific about the project we can set it up here instead of just a default one
7. `https://localhost:8080/applications` - the last step is to set applications using configs from `k8s-yaml/app/argo-deployment-demo-app`, it's gonna be one app per overlay folder which customizes the base folder for `argo-deployment-demo-app` app

### Going back to AWS infrastructure

1. `aws/iac/r53.tf` - a new ALB is gonna be deployed once we deploy ingress object for the first application, so, we need to get it's DNS name, set it there, and re-apply TF

## Important notice about working with NAT instances

Once this repo is cloned from GitHub, before doing `terraform apply` make sure to check Line Separators for .sh scripts in `modules/nat` they should be using linux format equal to`LF`.
Otherwise, you have a risk of facing weird issues when userdata script will fail and, as a result, Network Interface with EIP tied to it will not be attached to the newly created NAT instance.

Also, make sure not to do Instance Refresh for ASG used for NAT instance when the new instance is being created before the old one is deleted - unless Network Interface isn't unattached from the old instance, the new one won't be able to attach it, script that's doing it will fail.