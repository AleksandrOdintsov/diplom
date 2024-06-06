#!bin/bash

set -e 
# переименовываем папку inventory/sample в /inventory/mycluster и копируем туда наш файл hosts.yaml
mv /kubespray/inventory/sample kubespray/inventory/mycluster
cp -rfp hosts.yaml  /kubespray/inventory/mycluster

# настриваим kubespray что бы получить файл конфигурации
echo kubeconfig_localhost: true >> /kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml 

# запускаем kubespray
cd kubespray
sudo ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml 

# меняем приватный адрес на публичный в конфигурации kubeconfig
cd ../../terraform
MASTER_1_PRIVATE_IP=$(terraform output -json masters_private_ips | jq -j ".[0]")
MASTER_1_PUBLIC_IP=$(terraform output -json masters_public_ips | jq -j ".[0]")
sed -i -- "s/$MASTER_1_PRIVATE_IP/$MASTER_1_PUBLIC_IP/g" ~/devops-netology/diplom/k8s/kubespray/inventory/mycluster/artifacts/admin.conf
# копируем файл конфигурации 
cp ~/devops-netology/diplom/k8s/kubespray/inventory/mycluster/artifacts/admin.conf ~/.kube/config
