# az acr list
ACR_NAME=k8scourse
EMAIL=erick.speaker@hotmail.com
PASS=$(az acr credential show -n $ACR_NAME --query "passwords[0].value")
PASS=${PASS//\"}

ACR_USERNAME=$(az acr credential show -n $ACR_NAME --query "username")
ACR_USERNAME=${ACR_USERNAME//\"}
SECRET_NAME=acr-credentials



kubectl delete secret $SECRET_NAME
kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=$ACR_NAME.azurecr.io \
    --docker-username=$ACR_NAME \
    --docker-password=$PASS \
    --docker-email=$EMAIL 

kubectl get secret acr-credentials -o json > docker-registry-secret.json
    
kubectl delete -f heroes-pod.json

kubectl create -f heroes-pod.json
kubectl expose -f heroes-pod.json --port 4000 --type=LoadBalancer


echo -n $ACR_USERNAME | base64
echo -n $PASS | base64

kubectl create -f secret.json

echo 'MWYyZDFlMmU2N2Rm' | base64 --decode
