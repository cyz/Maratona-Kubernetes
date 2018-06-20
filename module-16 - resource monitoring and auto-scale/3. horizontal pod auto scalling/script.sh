kubectl scale deployment api-heroes --replicas 20
kubectl delete hpa api-heroes
kubectl autoscale deployment api-heroes --cpu-percent 10 --max 10 --min 5
kubectl get hpa -w
kubectl describe hpa api-heroes
git clone https://github.com/kubernetes-incubator/metrics-server.git
cd metrics-server/deploy/1.8+
for D in `ls`
do
  echo " creating.. $D"
  kubectl create -f $D
done
cd ....


HOST=$(kubectl get svc | grep api-heroes | awk '{print $4}')
siege -c60 -t30S  http://$HOST:4000/heroes
