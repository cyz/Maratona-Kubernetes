
kubectl create -f nginx.yaml
kubectl get deployment

# "spec": {
#     "replicas": 3,
#     "selector": {
#       "matchLabels": {
#         "version": "v1",
#         "app": "api-heroes"
#       }
#     },
kubectl apply -f heroes-deploy.json --record
kubectl get deploy api-heroes
kubectl rollout history deployment api-heroes
kubectl rollout status deployment api-heroes
kubectl rollout undo deployment api-heroes --to-revision=1 
kubectl set image deployment api-heroes api-heroes=k8scourse.azurecr.io/api-heroes:3 --record

kubectl replace -f heroes-deploy.json --record
kubectl edit deployment api-heroes --record

kubectl rollout pause deployment api-heroes
kubectl rollout resume deployment api-heroes
