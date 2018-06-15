kubectl get namespaces
NAMESPACE=production
kubectl --namespace=$NAMESPACE run nginx --image=nginx
kubectl --namespace=$NAMESPACE get pods
kubectl config set-context $(kubectl config current-context) --namespace $NAMESPACE
kubectl config set-context $(kubectl config current-context) --namespace default

kubectl get namespaces --show-labels
kubectl config use-context prod

ACR_NAME=k8scourse
EMAIL=erick.speaker@hotmail.com
PASS=$(az acr credential show -n $ACR_NAME --query "passwords[0].value")
PASS=${PASS//\"}

ACR_USERNAME=$(az acr credential show -n $ACR_NAME --query "username")
ACR_USERNAME=${ACR_USERNAME//\"}
SECRET_NAME=acr-credentials

kubectl create secret docker-registry $SECRET_NAME \
    --docker-server=$ACR_NAME.azurecr.io \
    --docker-username=$ACR_NAME \
    --docker-password=$PASS \
    --docker-email=$EMAIL 

kubectl get secret acr-credentials -o yaml