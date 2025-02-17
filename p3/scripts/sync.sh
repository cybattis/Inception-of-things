#!/bin/bash

echo -e "\033[1;3;34m=== Start manual sync ===\033[0m"

pkill -f "kubectl port-forward svc/iot-service -n dev 8888:8888"

argocd app sync iot

kubectl port-forward svc/iot-service -n dev 8888:8888 &> /dev/null &

echo -e "\033[1;3;34m=== Done ===\033[0m"
