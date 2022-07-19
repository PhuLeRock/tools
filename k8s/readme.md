https://registry.terraform.io/modules/terraform-aws-modules/eks/aws/latest?tab=inputs


touch infra/{version.tf,main.tf,output.tf,terraform.tfvars,variables.tf}

install tfswitch then choose version 1.1.0

from S3 backend https://technology.doximity.com/articles/terraform-s3-backend-best-practices
đầu tiên là viết file state.tf, trong đó có deploy các s3 kms dynamo để lưu tf state. Nhớ kiểm tra đang dùng profile nào
làm tiếp: chạy apply để tạo backend xong rồi mới add backend vào terraform { }. giờ lo học lái xe đã
.
.
.
đã chạy terraform apply
đã add terraform backend state và state.tf
đã chạy terraform init (chạy lại lần này để đổi state management), nhớ coi log output có thông báo
đã chạy terraform plan
tới khúc này coi như xong document s3 backend

đi tìm document về eks, qtrong là coi role tạo trước như nào, hoặc dùng role có sẵn của aduro thì làm cách nào
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster (trong này có hướng dẫn tạo role cơ bản coi coi đủ dùng không)

how to: https://www.techtarget.com/searchcloudcomputing/tutorial/How-to-deploy-an-EKS-cluster-using-Terraform (chỉ có subnet mà ko có vpcid, là sao nhỉ ?)

tới khúc này làm cho lẹ coi phần how to sau đó chuyển subnet, các name, profile rồi dựng cluster lên, kèm với script get kubeconf mới để khi reset cluster thì cac deployment chạy bt

note:
- k8s vs eks (kube >1.16): we can use iam role as k8s's service account by using OpenID Connect. By this feature we can manage users inside k8s cluter by leveraging IAM. We can also use Cognito user pool or another system that support oauth2 to authenticate against the cluster. BUT AWS RECOMMEND ADMIN SHOULD YOU THEIR OWN OPENID PROVIDER INSTEAD IAM, BECAUSE MANY DEV TEAM DON'T HAVE ADMINISTRATOR ACCOUNT 
- kubeadmin upgrade plan && kubeadm upgrade apply v1.22.0

QUEST:
- How we manager users, service account, ENVs when using k8s ? 
each namespace have their own user, 