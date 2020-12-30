kubectl apply -f ingress.yaml
kubectl apply -f mainsite_deployment.yaml
kubectl apply -f mainsite_svc.yaml
kubectl apply -f serviceA_deployment.yaml
kubectl apply -f serviceA_svc.yaml
kubectl apply -f serviceB_deployment.yaml
kubectl apply -f serviceB_svc.yaml