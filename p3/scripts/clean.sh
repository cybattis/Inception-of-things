#!/bin/bash

echo -e "\033[1;3;34m=== Cleaning... ===\033[0m"

# Stop the port-forwarding scripts
pkill -f "kubectl port-forward svc/argocd-server -n argocd 8080:443"
pkill -f "kubectl port-forward svc/iot-app 8888 -n dev"

# Delete the namespaces
kubectl delete namespace argocd
kubectl delete namespace dev

# Stop the clutster
k3d cluster delete argocluster

echo -e "\033[1;3;34m=== Done ===\033[0m"
