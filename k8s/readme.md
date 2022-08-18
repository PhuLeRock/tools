https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest?tab=inputs


touch infra/{version.tf,main.tf,output.tf,terraform.tfvars,variables.tf}

install tfswitch then choose version 1.1.0

tạo state trước rồi rem lại

install helm = coi trong thư mục helm  (đã compatible với k8s rồi)

helm upgrade -i prometheus prometheus-community/prometheus \
    --namespace prometheus \
    --set alertmanager.persistentVolume.storageClass="gp2",server.persistentVolume.storageClass="gp2"
xong rồi, nhưng thiếu grafana

xem https://www.eksworkshop.com/intermediate/240_monitoring/




note:
- chạy s3 backend xong thì nhớ rem phần đó lại, để khi destroy nó ko báo lỗi.
- k8s vs eks (kube >1.16): we can use iam role as k8s's service account by using OpenID Connect. By this feature we can manage users inside k8s cluter by leveraging IAM. We can also use Cognito user pool or another system that support oauth2 to authenticate against the cluster. BUT AWS RECOMMEND ADMIN SHOULD YOU THEIR OWN OPENID PROVIDER INSTEAD IAM, BECAUSE MANY DEV TEAM DON'T HAVE ADMINISTRATOR ACCOUNT 
- kubeadmin upgrade plan && kubeadm upgrade apply v1.22.0
- need more than 1 subnet.
- fargate profile chỉ cho add các private subnet, nó là 1 serverless có namespace, cứ deployment trúng namespace đó là vào fargate
- kubectl event
- eks khác với k8s là nó gom hết mớ control plane đi đâu đó mà get pod -A không thấy etcd và các thứ khác đâu cả
- coi chừng version k8s mới quá thì kubectl authen ko được, test kĩ phần này
- terraform destroy thì cũng ko có xóa cloudwatch group
- cách dùng namespace: ngoài việc cho các env thì cũng nên tạo trước các ns platform dùng chung cho toàn bộ env, như monitoring.

QUEST:
- How we manager users, service account, ENVs when using k8s ? 
each namespace have their own user
- how to deploy to specific node groupd ? label
- 