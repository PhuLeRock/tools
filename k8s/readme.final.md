
kubectl apply -f ../read-group.yaml
tao access key cho user phulerockeks
add aws configure

kubectl edit -n kube-system configmap/aws-auth :
 ...
  mapUsers: |
    - userarn: arn:aws:iam::667656621301:user/phulerockeks
      username: phulerockeks
      groups: 
      - reader
 ... 


aws eks update-kubeconfig \
  --region ap-southeast-1 \
  --name my-cluster \
  --profile phulerockeks
verify by kubectl config view --minify; kubectl auth can-i get pods; kubectl auth can-i create pods, kubectl run nginx --image=nginx

tao access key cho user phulerockeksadmin, aws configure
check role
aws sts assume-role \
  --role-arn arn:aws:iam::667656621301:role/eks-admin \
  --role-session-name manager-session \
  --profile phulerockeksadmin

back to root profile
aws eks update-kubeconfig \
  --region ap-southeast-1 \
  --name my-cluster \
  --profile phulerock

kubectl edit -n kube-system configmap/aws-auth

###
eksctl utils associate-iam-oidc-provider \
    --region ap-southeast-1 \
    --cluster my-cluster \
    --approve

curl -o iam-policy.json https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.2.1/docs/install/iam_policy.json

aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam-policy.json
    
eksctl create iamserviceaccount \
--cluster=my-cluster \    
--namespace=kube-system \
--name=aws-load-balancer-controller \
--attach-policy-arn=arn:aws:iam::667656621301:policy/AWSLoadBalancerControllerIAMPolicy \
--override-existing-serviceaccounts \
--approve

helm repo add eks https://aws.github.io/eks-charts
kubectl apply -k "github.com/aws/eks-charts/stable/aws-load-balancer-controller/crds?ref=master"
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=my-cluster --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller

kubectl logs -f -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller 

add tags to subnets:
kubernetes.io/cluster/$CLUSTER_NAME    shared
kubernetes.io/role/elb 1  (this is for internet facing)

kubectl apply -f echoserver.yaml
