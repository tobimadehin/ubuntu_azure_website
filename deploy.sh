#!/bin/bash

az group create --name my_resource_group --location westus

az vm availability-set create --resource-group my_resource_group --name my_availability_set --platform-fault-domain-count 2 --platform-update-domain-count 2

az network public-ip create --resource-group my_resource_group --name my_public_ip

az network lb create --resource-group my_resource_group --name my_load_balancer --frontend-ip-name my_front_end_pool --backend-pool-name my_back_end_pool --public-ip-address my_public_ip

az network lb probe create --resource-group my_resource_group --lb-name my_load_balancer --name my_health_probe --protocol tcp --port 80

az network lb rule create --resource-group my_resource_group --lb-name my_load_balancer --name my_load_balancer_rule --protocol tcp --frontend-port 80 --backend-port 80 --frontend-ip-name my_front_end_pool --backend-pool-name my_back_end_pool --probe-name my_health_probe

for i in `seq 1 2`; do
   az vm create \
     --resource-group my_resource_group \
     --name ubuntu_azure_vm$i \
     --availability-set my_availability_set \
     --size Standard_DS1_v2  \
     --image UbuntuLTS \
     --admin-username azureuser \
     --generate-ssh-keys \
     --custom-data cloud-init.txt
done

for i in `seq 1 2`; do
	az vm open-port --port 80 --resource-group my_resource_group --name ubuntu_azure_vm$i
done

az network public-ip show --resource-group my_resource_group --name my_public_ip --query [ipAddress] --output tsv