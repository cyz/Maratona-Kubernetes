kubectl create -f heroes-pod.json
kubectl create -f heroes-svc.json

kubectl create -f mongodb-pod.json
kubectl create -f mongodb-svc.json

kubectl get services -w 

mongo 52.170.146.14
show dbs
#insert
show dbs

use heroes
show collections
db.hero.find().pretty()