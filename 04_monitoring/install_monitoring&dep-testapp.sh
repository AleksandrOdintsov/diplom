#!bin/bash

set -e 
echo "склонируем репозитарий"
git clone https://github.com/prometheus-operator/kube-prometheus

echo "репозитарий kube-prometheus склонирован"

echo  "Создаем стек мониторинга, используя конфигурацию в manifests каталоге"
cd kube-prometheus
kubectl apply --server-side -f manifests/setup
kubectl wait \
	--for condition=Established \
	--all CustomResourceDefinition \
	--namespace=monitoring
kubectl apply -f manifests/
echo "Стек монитора установлен"


echo "Откроем доступ к grafana через nodeport и изменим сетевые политики"
cd ..
kubectl apply -f grafana-nodeport\&acsess.yaml 
kubectl delete -f kube-prometheus/manifests/grafana-networkPolicy.yaml
# Задипломи наше приложение в namaspase diplom
helm install myapp myapp/

sleep 10
kubectl get pods -n 
kubectl get pods -n monitoring

open "http://$PUBLIC_MASTER_IPS:30002"