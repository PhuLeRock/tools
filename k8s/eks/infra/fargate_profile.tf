
resource "aws_iam_role" "aduro-eks-fargate" {
  depends_on = [
    aws_eks_cluster.devopsthehardway-eks
  ]
  name = "aduro-eks-fargate-profile"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.aduro-eks-fargate.name
}

resource "aws_eks_fargate_profile" "aduro-eks-fargate" {
  cluster_name           = var.eks_clustername
  fargate_profile_name   = "aduro-eks-fargate"
  pod_execution_role_arn = aws_iam_role.aduro-eks-fargate.arn
  subnet_ids             = [var.subnet_id_4, var.subnet_id_3]

  selector {
    namespace = "kube-system"
  }
}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.devopsthehardway-eks.id
}

resource "null_resource" "k8s_patcher" {
  depends_on = [aws_eks_fargate_profile.aduro-eks-fargate]

  triggers = {
    endpoint = aws_eks_cluster.devopsthehardway-eks.endpoint
    ca_crt   = base64decode(aws_eks_cluster.devopsthehardway-eks.certificate_authority[0].data)
    token    = data.aws_eks_cluster_auth.eks.token
  }

  provisioner "local-exec" {
    command = <<EOH
cat >/tmp/ca.crt <<EOF
${base64decode(aws_eks_cluster.devopsthehardway-eks.certificate_authority[0].data)}
EOF
kubectl \
  --server="${aws_eks_cluster.devopsthehardway-eks.endpoint}" \
  --certificate_authority=/tmp/ca.crt \
  --token="${data.aws_eks_cluster_auth.eks.token}" \
  patch deployment coredns \
  -n kube-system --type json \
  -p='[{"op": "remove", "path": "/spec/template/metadata/annotations/eks.amazonaws.com~1compute-type"}]'
EOH
  }

  lifecycle {
    ignore_changes = [triggers]
  }
}
