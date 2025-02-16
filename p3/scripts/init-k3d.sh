#!/bin/bash
set -euo pipefail

echo -e "\033[1;3;34m=== Init k3d cluster... ===\033[0m"
sudo k3d cluster create argocluster --agents 2

sudo kubectl create namespace argocd
sudo kubectl create namespace dev

sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

echo -e "\033[1;3;34m=== Waiting Argo CD Setup ===\033[0m"

# params="-n argocd -l app.kubernetes.io/name=argocd-server --timeout=10m"
# kubectl wait --for=condition=available deployment $params
# kubectl wait --for=condition=ready pod $params

kubectl port-forward svc/argocd-server -n argocd 8080:443

kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d

echo -e "\033[1;3;34m=== Done ===\033[0m"