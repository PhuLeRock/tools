helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts



kubectl create namespace prometheus
helm install prometheus prometheus-community/prometheus \
    --namespace prometheus
kubectl patch ds/prometheus-node-exporter --type "json" -p '[{"op": "remove", "path" : "/spec/template/spec/containers/0/volumeMounts/2/mountPropagation"}]' -n prometheus
kubectl get all -n prometheus
kubectl port-forward -n prometheus deploy/prometheus-server 8080:9090

go to http://localhost:8080/

kubectl create namespace grafana
helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \ 
    --values ../helm/grafana/grafana.yaml \
    --set service.type=NodePort


kubectl get all -n grafana

xxxx export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "http://$ELB"

 helm repo add bitnami https://charts.bitnami.com/bitnami
 helm install wp \
  --set service.type=NodePort \
  --set wordpressUsername=admin \
  --set wordpressPassword=ThuyLinho! \
  --set db.password=NcIrZZnVhnACdA \
  --set mariadb.auth.rootPassword=NcIrZZnVhnACdA \
    bitnami/wordpress

# deploy tới đây thì wp ko chạy nó bitnami wp nó lỗi, phải vào mysql alter lai pass của user, rồi vào secret update lại luôn

kubectl run test --image=alpine:3.7 --restart=Never -- tail -f /dev/null

apk add mariadb
mysqlslap --host --user=root --port=3306 --host=wp-mariadb.default.svc.cluster.local --password=NcIrZZnVhnACdA \
--concurrency=100 --iterations=20 --number-int-cols=2 --number-char-cols=3 \
--auto-generate-sql
#kubectl delete pod test