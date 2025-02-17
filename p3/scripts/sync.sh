#!/bin/bash

echo -e "\033[1;3;34m=== Start manual sync ===\033[0m"

pkill -f "kubectl port-forward svc/iot-app 8888 -n dev"

argocd app sync iot

kubectl wait --for=condition=Ready pods --all --timeout=300s -n dev

sleep 5

argocd app get iot

kubectl port-forward svc/iot-app 8888 -n dev &> /dev/null &
echo "done, use curl localhost:8888 to check.."

echo -e "\033[1;3;34m=== Done ===\033[0m"
