#!/bin/bash

# Stop the port-forwarding scripts
pkill -f "kubectl port-forward svc/argocd-server -n argocd 8080:443"
pkill -f "kubectl port-forward svc/iot-service -n dev 8888:8888"

# Delete the namespaces
kubectl delete namespace argocd
kubectl delete namespace dev

# Stop the clutster
k3d cluster delete argocluster

