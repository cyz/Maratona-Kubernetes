# emptyDir #usado somente para dados temporário, quando um pod morre, ele perde todos os dados

kubectl create -f 1.\ persistent-volume.json \
-f 2.\ persistent-volume-claim.json \
-f 3.\ upload-app.json


kubectl expose -f 3.\ upload-app.json --type LoadBalancer --port 3000
