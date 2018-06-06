RESOURCE=k8s-course-aks
CLUSTER_NAME=k8s-cluster
ADMIN_USER_NAME=azureuser
ADMIN_USER_PWD=Erick@123345
VM_SIZE=Standard_B1s
LOCATION=eastus
# eastus, westeurope, centralus, canadacentral, canadaeast
az group create --name $RESOURCE --location $LOCATION

az provider register -n Microsoft.ContainerService
az provider register -n Microsoft.Storage
az provider register -n Microsoft.Network 
az provider register -n Microsoft.Compute 

# az aks install-cli

# az aks create –n $CLUSTER_NAME –g $RESOURCE
# sudo chown -R $(whoami) / usr/local/bin

# sudo chmod 755 /usr/local/lib

az aks create -g k8s-course-aks-1\
    --name k8s-cluster\
    --dns-name-prefix k8s-cluster\
    --node-vm-size Standard_B1s
    --node-count 2

time; 
az aks create --resource-group $RESOURCE\
 --name $CLUSTER_NAME \
 --dns-name-prefix $CLUSTER_NAME \
 --generate-ssh-keys \
 --node-count 1 \
 --node-vm-size $VM_SIZE 
time; 

az aks get-credentials --resource-group $RESOURCE --name $CLUSTER_NAME
 
az aks browse --resource-group $RESOURCE --name $CLUSTER_NAME

az aks delete --name $CLUSTER_NAME --resource-group $RESOURCE --yes

az group delete --name $RESOURCE --yes

az aks scale --resource-group=myResourceGroup --name=myAKSCluster --node-count 3

kubectl scale --replicas=5 deployment/azure-vote-front

