kubectl create -f heroes-rc.json

kubectl describe rc api-heroes-rc

kubectl expose -f heroes-rs.json --port=4000 --type=LoadBalancer

kubectl 