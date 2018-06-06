¡
az acr list
ACR_NAME=k8scourse

kubectl describe deployment api-heroes

kubectl run mongodb --image=mongo:3.5  --port=27017

kubectl run api-heroes \
    --replicas=2 \
    --image=erickwendel/nodejs-with-mongodb-example \
    --env="MONGO_URL=10.244.0.109" \
    --port=4000

# kubectl expose deployment api-heroes --port=4000 --type=LoadBalancer
kubectl expose -f heroes-pod.json --port 4000 --type=LoadBalancer
kubectl get services -w

#kubectl delete pod api-heroes-66964b8f9b-h6w8m --recria

kubectl delete deployment api-heroes

kubectl explain pods,svc

kubectl get pods -o wide

kubectl describe pods my-pod

kubectl get pods --selector=app=cassandra rc -o \
  jsonpath='{.items[*].metadata.labels.version}'

kubectl top pod

kubectl logs my-pod


kubectl exec -it envar-demo -- /bin/bash
kubectl get pod mongodb-77fc45979b-wphhm -o yaml | grep podIP