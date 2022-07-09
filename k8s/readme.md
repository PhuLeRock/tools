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


