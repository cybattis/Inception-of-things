#!/bin/bash

set -euo pipefail

echo -e "\033[1;3;34m=== Init k3d cluster ===\033[0m"

# Create the cluster
k3d cluster create argocluster

echo -e "\033[1;3;34m=== Init Argocd ===\033[0m"

# Argocd
kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl wait pods --all -n argocd --for condition=Ready --timeout=300s
kubectl port-forward svc/argocd-server -n argocd 8080:443 &> /dev/null &

INIT_PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

echo y | argocd login localhost:8080 --username admin --password "$INIT_PASSWORD"

argocd account update-password --current-password "$INIT_PASSWORD" --new-password Password

argocd app create iot --repo https://github.com/NathanJennes/IOT-argocd --path app --dest-server https://kubernetes.default.svc --dest-namespace dev

argocd app sync iot

argocd app set iot --sync-policy automated
argocd app set iot --auto-prune
argocd app set iot --self-heal

kubectl wait --for=condition=Ready pods --all --timeout=300s -n dev
kubectl port-forward svc/iot-app 8888 -n dev &> /dev/null &

echo -e "\033[1;3;34m=== Done ===\033[0m"
