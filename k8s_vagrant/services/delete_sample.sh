kubectl delete -f ingress.yaml
kubectl delete -f mainsite_deployment.yaml
kubectl delete -f mainsite_svc.yaml
kubectl delete -f serviceA_deployment.yaml
kubectl delete -f serviceA_svc.yaml
kubectl delete -f serviceB_deployment.yaml
kubectl delete -f serviceB_svc.yaml