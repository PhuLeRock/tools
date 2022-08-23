<<comment
 "Code" or "Comments"
comment

terraform apply -auto-approve; sleep 10
aws eks update-kubeconfig --name aduro-eks-demo --region us-west-2 --profile default


helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts

kubectl create namespace prometheus
helm install prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2" \
    --set server.persistentVolume.storageClass="gp2"
kubectl get all -n prometheus
kubectl port-forward -n prometheus deploy/prometheus-server 8080:9090

mkdir -p ../helm/grafana/
cat << EoF > ../helm/grafana/grafana.yaml
datasources:
  datasources.yaml:
    apiVersion: 1
    datasources:
    - name: Prometheus
      type: prometheus
      url: http://prometheus-server.prometheus.svc.cluster.local
      access: proxy
      isDefault: true
EoF

kubectl create namespace grafana

helm install grafana grafana/grafana \
    --namespace grafana \
    --set persistence.storageClassName="gp2" \
    --set persistence.enabled=true \
    --set adminPassword='EKS!sAWSome' \
    --values ../helm/grafana/grafana.yaml \
    --set service.type=LoadBalancer

kubectl get all -n grafana
export ELB=$(kubectl get svc -n grafana grafana -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')

echo "http://$ELB"
kubectl get secret --namespace grafana grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo


#terraform destroy -auto-approve