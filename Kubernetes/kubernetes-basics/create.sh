#!/bin/bash

kubectl apply -f manifests/namespace.yaml
kubectl apply -n demo -f manifests/configmap.yaml
kubectl apply -n demo -f manifests/statefulset-advanced.yaml
kubectl apply -n demo -f manifests/service.yaml
kubectl apply -n demo -f manifests/ingress-tls.yaml