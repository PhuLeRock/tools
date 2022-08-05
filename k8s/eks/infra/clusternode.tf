
resource "aws_iam_role" "eks-iam-role" {
 name = var.eks_iam_role_name
 path = "/"
 assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
  {
   "Effect": "Allow",
   "Principal": {
    "Service": "eks.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
 ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
 role    = aws_iam_role.eks-iam-role.name
}
resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly-EKS" {
 policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
 role    = aws_iam_role.eks-iam-role.name
}

resource "aws_eks_cluster" "devopsthehardway-eks" {
 name = var.eks_clustername
 version = 1.22
 role_arn = aws_iam_role.eks-iam-role.arn
 
 enabled_cluster_log_types = ["api", "audit"]
 vpc_config {
  subnet_ids = [var.subnet_id_1, var.subnet_id_2]
 }

 depends_on = [
  aws_iam_role.eks-iam-role, aws_cloudwatch_log_group.aduro-eks-demo
 ]
}
resource "aws_cloudwatch_log_group" "aduro-eks-demo" {
  name              = "/aws/eks/${var.eks_clustername}/cluster"
  retention_in_days = 7
}

