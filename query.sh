#!/bin/bash
POD=$(kubectl get pods -n jenkins -o json | jq '.items[1].metadata.name' | xargs)
echo "Jenkins credentials"
echo username: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_USER | sed 's/.*=//')
echo password: $(kubectl -n jenkins --container jenkins exec $POD -- env | grep ADMIN_PASSWORD | sed 's/.*=//')
echo port: $(kubectl get service jenkins -n jenkins -o json | jq '.spec.ports[0].nodePort')
kubectl create clusterrolebinding jenkins --clusterrole cluster-admin --serviceaccount=jenkins:jenkins -n app
#kubectl create rolebinding elk --clusterrole=admin --serviceaccount=jenkins:default --namespace=elk
#kubectl create clusterrolebinding elk --clusterrole cluster-admin --serviceaccount=jenkins:jenkins -n elk
#kubectl create clusterrolebinding grafana --clusterrole cluster-admin --serviceaccount=jenkins:jenkins -n monitor
