variable "region" { }
variable "profile" { }
variable "vpcid" { }
variable "subnet_id_1" { }
variable "subnet_id_2" { }
variable "subnet_id_3" { }
variable "subnet_id_4" { }
variable "eks_clustername" { }
variable "eks_iam_role_name" { }
variable "eks_node_group_role_name" {}
variable "eks_node_group01_name" { }
variable "eks_node_group02_name" { }
variable "eks_node_group_instance_type" { }
variable "eks_node_group_desired_size" { type = number }
variable "eks_node_group_minsize" { type = number }
variable "eks_node_group_maxsize" { type  = number}