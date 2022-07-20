variable "region" { }
variable "profile" { }
variable "subnet_id_1" { }
variable "subnet_id_2" { }
variable "eks_iam_role_name" { }
variable "eks_node_group_role_name" {}
variable "eks_node_group_name" { }
variable "eks_node_group_instance_type" { }
variable "eks_node_group_desired_size" { type = number }
variable "eks_node_group_minsize" { type = number }
variable "eks_node_group_maxsize" { type  = number}