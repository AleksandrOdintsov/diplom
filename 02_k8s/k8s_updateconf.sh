# меняем приватный адрес на публичный в конфигурации kubeconfig
cd ../01_terraform
terraform apply
sleep 5 
MASTER_1_PRIVATE_IP=$(terraform output -json masters_private_ips | jq -j ".[0]")
MASTER_1_PUBLIC_IP=$(terraform output -json masters_public_ips | jq -j ".[0]")

# Получаем список IP-адресов мастеров из вывода Terraform
MASTER_IPS=$(terraform output -json masters_private_ips | jq -r '.[0]')
PUBLIC_MASTER_IPS=$(terraform output -json masters_public_ips | jq -r '.[0]')

echo  "Проверяем, что переменные были найдены"
if [ -n "$MASTER_IPS" ] && [ -n "$PUBLIC_MASTER_IPS" ]; then
  # Записываем новые значения в переменные
  export MASTER_1_PRIVATE_IP="$MASTER_IPS"
  export MASTER_1_PUBLIC_IP="$PUBLIC_MASTER_IPS"
else
  echo "Не удалось получить IP-адреса мастеров из вывода Terraform."
fi

echo "Обновляем конфигурацию Kubespray с новыми IP-адресами"
sed -i -- "s/$MASTER_1_PRIVATE_IP/$MASTER_1_PUBLIC_IP/g" ~/devops-netology/diplom/02_k8s/kubespray/inventory/mycluster/artifacts/admin.conf
echo "конфигурация Kubespray с новыми IP-адресами обновлена"

echo "копируем файл конфигурации"
cp ~/devops-netology/diplom/02_k8s/kubespray/inventory/mycluster/artifacts/admin.conf ~/.kube/config
echo "конфигурация скопирован"