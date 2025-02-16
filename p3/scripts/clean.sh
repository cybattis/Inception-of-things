#!/bin/bash

set -euo pipefail

# Stop the port-forwarding scripts
pkill -f "kubectl port-forward -n argocd svc/argocd-server -n argocd 8080:443"

# Delete the namespaces
kubectl delete namespace argocd
kubectl delete namespace dev

# Stop the clutster
k3d cluster delete mycluster

