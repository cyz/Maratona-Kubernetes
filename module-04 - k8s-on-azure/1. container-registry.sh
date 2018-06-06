RESOURCE=k8s-course
LOCATION=eastus
REGISTRY_NAME=k8scourse
REGISTRY_URL=$REGISTRY_NAME.azurecr.io
PRIVATE_APP_NAME=$REGISTRY_URL/api-heroes

# az group create --name $RESOURCE --location $LOCATION

az account set --subscription "$SUBSCRIPTION"


az acr create --resource-group $RESOURCE --name $REGISTRY_NAME --sku Basic

az acr login --name $REGISTRY_NAME

docker images

az acr list --resource-group $RESOURCE \
    --query "[].{acrLoginServer:loginServer}" \
    --output table


docker tag erickwendel/api-heroes $PRIVATE_APP_NAME

docker images 

az acr login --resource-group $RESOURCE --name $REGISTRY_NAME

docker push $PRIVATE_APP_NAME
