#!/bin/bash

kubectl create namespace logging-stack
kubectl create namespace apps

echo "Aplicando Elasticsearch..."
kubectl apply -f elasticsearch/elasticsearch-statefulset.yaml -n logging-stack
kubectl apply -f elasticsearch/elasticsearch-service.yaml -n logging-stack

echo "Aplicando Kibana..."
kubectl apply -f kibana/kibana-deployment.yaml -n logging-stack
kubectl apply -f kibana/kibana-service.yaml -n logging-stack

echo "Aplicando Filebeat..."
kubectl apply -f filebeat/filebeat-configmap.yaml -n logging-stack
kubectl apply -f filebeat/filebeat-rbac.yaml -n logging-stack
kubectl apply -f filebeat/filebeat-daemonset.yaml -n logging-stack

echo "Desplegando microservicio de ejemplo (nginx)..."
kubectl apply -f apps/nginx-deployment.yaml -n apps

echo "✅ Stack ELK desplegado. Accede a Kibana vía: minikube service kibana -n logging-stack"
