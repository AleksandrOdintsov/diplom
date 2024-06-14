#!bin/bash

set -e 
# переименовываем папку inventory/sample в /inventory/mycluster и копируем туда наш файл hosts.yaml
if [ ! -d "kubespray/inventory/mycluster" ]; then
  # Переименовываем папку sample в mycluster
  mv kubespray/inventory/sample kubespray/inventory/mycluster
  echo "Папка  kubespray/inventory/sample переименована  в kubespray/inventory/mycluster"
else
  echo "Папка kubespray/inventory/mycluster уже существует. Переименование не требуется."
fi
echo "Папка  kubespray/inventory/sample переименована  в kubespray/inventory/mycluster"
cp -rfp hosts.yaml  kubespray/inventory/mycluster
echo "Скопирован hosts.yaml  в kubespray/inventory/mycluster"

# настриваим kubespray что бы получить файл конфигурации
echo kubeconfig_localhost: true >> kubespray/inventory/mycluster/group_vars/k8s_cluster/k8s-cluster.yml 

# запускаем kubespray в фоновом режиме
cd kubespray
ansible-playbook -i inventory/mycluster/hosts.yaml --become --become-user=root cluster.yml &
ANSIBLE_PID=$!
wait $ANSIBLE_PID
ANSIBLE_STATUS=$?
if [ $ANSIBLE_STATUS -eq 0 ]; then
  echo "Успешное выполнение playbook Ansible"
else
  echo "Ошибка при выполнении playbook Ansible, но продолжаем выполнение скрипта"
fi

