#!/bin/bash

set -euo pipefail

echo -e "\033[1;3;34m=== Init k3d cluster ===\033[0m"

# Create the cluster
k3d cluster create argocluster

echo -e "\033[1;3;34m=== Init Argocd ===\033[0m"

# Argocd
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubcontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait pods --all -n argocd --for condition=Ready --timeout=300s
kubectl port-forward svc/argocd-server -n argocd 8080:443 > /dev/null &
