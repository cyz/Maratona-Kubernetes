#brew install azure-cli
# az login 

RESOURCE=k8s-course-vm
VNET=vnet
SUBNET=mySubnet
NETWORK_SECURITY_GROUP=securityGroup
AVAILABILIT_SET=availabilitySet
LOCATION=southcentralus

NETWORK_INTERFACE_1=myNic1
PUBLIC_IP_1=master-k8s
DNS_NAME_1=master-k8s
VM_NAME_1=master-k8s

NETWORK_INTERFACE_2=myNic2
PUBLIC_IP_2=node1-k8s
DNS_NAME_2=node1-k8s
VM_NAME_2=node1-k8s

NETWORK_INTERFACE_3=myNic3
PUBLIC_IP_3=node2-k8s
DNS_NAME_3=node2-k8s
VM_NAME_3=node2-k8s

IMAGE_NAME=UbuntuLTS
ADMIN_USER_NAME=azureuser
ADMIN_USER_PWD=Erick@123345

SUBSCRIPTION="Azure Pass"

az account set --subscription "$SUBSCRIPTION"

az group create --name $RESOURCE --location $LOCATION

az network vnet create \
    --resource-group $RESOURCE \
    --name $VNET \
    --address-prefix 192.168.0.0/16 \
    --subnet-name $SUBNET \
    --subnet-prefix 192.168.1.0/24

#network security group 
az network nsg create \
    --resource-group $RESOURCE \
    --name $NETWORK_SECURITY_GROUP


#ports
az network nsg rule create \
    --resource-group $RESOURCE \
    --nsg-name $NETWORK_SECURITY_GROUP \
    --name "${NETWORK_SECURITY_GROUP}"RuleSSH \
    --protocol tcp \
    --priority 1000 \
    --destination-port-range 22 \
    --access allow


az network nsg rule create \
    --resource-group $RESOURCE \
    --nsg-name $NETWORK_SECURITY_GROUP \
    --name "${NETWORK_SECURITY_GROUP}"RuleFront1 \
    --protocol tcp \
    --priority 1003 \
    --destination-port-range 8081 \
    --access allow

az network nsg rule create \
    --resource-group $RESOURCE \
    --nsg-name $NETWORK_SECURITY_GROUP \
    --name "${NETWORK_SECURITY_GROUP}"RuleFront2 \
    --protocol tcp \
    --priority 1004 \
    --destination-port-range 80 \
    --access allow

az network nsg show --resource-group $RESOURCE --name $NETWORK_SECURITY_GROUP

#vms
az network public-ip create \
    --resource-group $RESOURCE \
    --name $PUBLIC_IP_1 \
    --dns-name $DNS_NAME_1

az network public-ip create \
    --resource-group $RESOURCE \
    --name $PUBLIC_IP_2 \
    --dns-name $DNS_NAME_2

az network public-ip create \
    --resource-group $RESOURCE \
    --name $PUBLIC_IP_3 \
    --dns-name $DNS_NAME_3


#Virtual network interface cards (NICs) 
# Virtual network interface cards (NICs) are programmatically available because you can apply rules to their use. 
# Depending on the VM size, you can attach multiple virtual NICs to a VM.
az network nic create \
    --resource-group $RESOURCE \
    --name $NETWORK_INTERFACE_1 \
    --vnet-name $VNET \
    --subnet $SUBNET \
    --public-ip-address $PUBLIC_IP_1 \
    --network-security-group $NETWORK_SECURITY_GROUP

az network nic create \
    --resource-group $RESOURCE \
    --name $NETWORK_INTERFACE_2 \
    --vnet-name $VNET \
    --subnet $SUBNET \
    --public-ip-address $PUBLIC_IP_2 \
    --network-security-group $NETWORK_SECURITY_GROUP

az network nic create \
    --resource-group $RESOURCE \
    --name $NETWORK_INTERFACE_3 \
    --vnet-name $VNET \
    --subnet $SUBNET \
    --public-ip-address $PUBLIC_IP_3 \
    --network-security-group $NETWORK_SECURITY_GROUP



az vm availability-set create \
    --resource-group $RESOURCE \
    --name $AVAILABILIT_SET

az vm create \
    --resource-group $RESOURCE \
    --name $VM_NAME_1 \
    --size Standard_B1s \
    --location $LOCATION \
    --availability-set $AVAILABILIT_SET \
    --nics $NETWORK_INTERFACE_1 \
    --image $IMAGE_NAME \
    --admin-username $ADMIN_USER_NAME \
    --admin-password $ADMIN_USER_PWD

az vm create \
    --resource-group $RESOURCE \
    --name $VM_NAME_2 \
    --size Standard_B1s \
    --location $LOCATION \
    --availability-set $AVAILABILIT_SET \
    --nics $NETWORK_INTERFACE_2 \
    --image $IMAGE_NAME \
    --admin-username $ADMIN_USER_NAME \
    --admin-password $ADMIN_USER_PWD

az vm create \
    --resource-group $RESOURCE \
    --name $VM_NAME_3 \
    --size Standard_B1s \
    --location $LOCATION \
    --availability-set $AVAILABILIT_SET \
    --nics $NETWORK_INTERFACE_3 \
    --image $IMAGE_NAME \
    --admin-username $ADMIN_USER_NAME \
    --admin-password $ADMIN_USER_PWD


ssh $ADMIN_USER_NAME:$ADMIN_USER_PWD@$DNS_NAME_1.$LOCATION.cloudapp.azure.com
ssh $ADMIN_USER_NAME:$ADMIN_USER_PWD@$DNS_NAME_2.$LOCATION.cloudapp.azure.com
ssh $ADMIN_USER_NAME:$ADMIN_USER_PWD@$DNS_NAME_3.$LOCATION.cloudapp.azure.com

# az vm delete -g $RESOURCE -n $VM_NAME_1 --yes
az vm delete -g $RESOURCE -n $VM_NAME_2 --yes
az vm delete -g $RESOURCE -n $VM_NAME_3 --yes

az group delete --name $RESOURCE --yes


#-------------------------------------------------
# on all nodes
sudo su
apt-get update
apt-get install -y docker.io

apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y   kubeadm kubectl

#

#on master
# kubeadm init
echo 'Environment="KUBELET_EXTRA_ARGS=--fail-swap-on=false"' > /etc/systemd/system/kubelet.service.d/90-local-extras.conf
systemctl daemon-reload
systemctl restart kubelet
systemctl status kubelet

#sudo swapoff -a

kubeadm init --ignore-preflight-errors=all

kubeadm reset

#on nodes
kubeadm join


## -------
apt-get update && apt-get install -y apt-transport-https

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list  
deb http://apt.kubernetes.io/ kubernetes-xenial main  
EOF

apt-get update
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni


