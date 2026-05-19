# argo-deployment-demo-infra
This is the demo project that shows how to deploy a [SpringBoot app](https://github.com/kolyaiks/argo-deployment-demo-app) to K8S cluster in AWS using Terraform, GitHub actions and ArgoCD.

## Overview
![Architecture](https://github.com/kolyaiks/argo-deployment-demo-infra/blob/main/argo-deployment-demo.drawio.png)

## Access to ArgoCD
1. `kubectl get secrets argocd-initial-admin-secret -o yaml -n argocd` - getting the secret
2. `kubectl port-forward svc/argocd-server -n argocd 8080:80` - proxy local port 8080 to argocd's ui pod


## Deploying to the cluster using just Kustomize

k8s-yaml is using Kustomize frameworks, so deployment of this thing should look like: 
```
cd argo-deployment-demo-infra/k8s-yaml/app/argo-deployment-demo-app/overlays/
kustomize build <overlay-name> | kubectl apply -f -
```