#!/bin/bash

echo -e "\033[1;3;34m=== Start manual sync ===\033[0m"

argocd app sync iot

kubectl port-forward svc/iot-app 8888 -n dev --address="0.0.0.0" &> /dev/null &

echo -e "\033[1;3;34m=== Done ===\033[0m"
