# This url for onprems approach.

# https://docs.nginx.com/nginx-ingress-controller/installation/installation-with-manifests/

# $ git clone https://github.com/nginxinc/kubernetes-ingress/
# $ cd kubernetes-ingress/deployments
# $ git checkout v1.8.1

kubectl apply -f common/ns-and-sa.yaml
kubectl apply -f rbac/rbac.yaml  # change from betav1 to v1
kubectl apply -f common/default-server-secret.yaml
kubectl apply -f common/nginx-config.yaml

# --validate=false for k8s v1.19
kubectl apply -f common/vs-definition.yaml --validate=false
kubectl apply -f common/vsr-definition.yaml --validate=false
kubectl apply -f common/ts-definition.yaml --validate=false
kubectl apply -f common/policy-definition.yaml --validate=false


kubectl apply -f daemon-set/nginx-ingress.yaml