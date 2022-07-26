
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

######## Worker nodes
resource "aws_security_group" "aduro-eks-workernodes" {
  name_prefix = "aduro-eks"
  vpc_id      = var.vpcid

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"

    cidr_blocks = [
      "10.0.0.0/8",
    ]
  }
}
resource "aws_iam_role" "workernodes" {
  name = var.eks_node_group_role_name
 
  assume_role_policy = jsonencode({
   Statement = [{
    Action = "sts:AssumeRole"
    Effect = "Allow"
    Principal = {
     Service = "ec2.amazonaws.com"
    }
   }]
   Version = "2012-10-17"
  })
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "EC2InstanceProfileForImageBuilderECRContainerBuilds" {
  policy_arn = "arn:aws:iam::aws:policy/EC2InstanceProfileForImageBuilderECRContainerBuilds"
  role    = aws_iam_role.workernodes.name
 }
 
 resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role    = aws_iam_role.workernodes.name
 }

 resource "aws_eks_node_group" "worker-node-group01" {
  cluster_name  = aws_eks_cluster.devopsthehardway-eks.name
  node_group_name = var.eks_node_group01_name
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [var.subnet_id_1, var.subnet_id_2]
  instance_types = [var.eks_node_group_instance_type]
  disk_size = 20
  remote_access {
    ec2_ssh_key = "Phu.Le"
    source_security_group_ids = [aws_security_group.aduro-eks-workernodes.id] 
  }
  
  
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }

 resource "aws_eks_node_group" "worker-node-group02" {
  cluster_name  = aws_eks_cluster.devopsthehardway-eks.name
  node_group_name = var.eks_node_group02_name
  node_role_arn  = aws_iam_role.workernodes.arn
  subnet_ids   = [var.subnet_id_1, var.subnet_id_2]
  instance_types = [var.eks_node_group_instance_type]
  disk_size = 20
  remote_access {
    ec2_ssh_key = "Phu.Le"
    source_security_group_ids = [aws_security_group.aduro-eks-workernodes.id] 
  }
  scaling_config {
   desired_size = 1
   max_size   = 1
   min_size   = 1
  }
 
  depends_on = [
   aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
   aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
   #aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly,
  ]
 }  
