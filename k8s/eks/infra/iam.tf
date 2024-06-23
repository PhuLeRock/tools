# Create user
resource "aws_iam_user" "user" {
  name = var.iamuser
}

# Create group  eksdeveloper and group policy 
resource "aws_iam_group" "eksdeveloper" {
  name = "eksdeveloper"
}
resource "aws_iam_group_membership" "add_user_to_group" {
  name  = "eksdeveloper-membership"
  users = [aws_iam_user.user.name]
  group = aws_iam_group.eksdeveloper.name
}

resource "aws_iam_policy" "AmazonEKSViewNodesAndWorkloadsPolicy" {
  name        = "AmazonEKSViewNodesAndWorkloadsPolicy"
  description = "IAM policy to let users view nodes and workloads for all clusters"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:DescribeNodegroup",
                "eks:ListNodegroups",
                "eks:DescribeCluster",
                "eks:ListClusters",
                "eks:AccessKubernetesApi",
                "ssm:GetParameter",
                "eks:ListUpdates",
                "eks:ListFargateProfiles"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
resource "aws_iam_group_policy_attachment" "attach_policy_to_eks_group" {
  group      = aws_iam_group.eksdeveloper.name  # Name of your IAM group
  policy_arn = aws_iam_policy.AmazonEKSViewNodesAndWorkloadsPolicy.arn
}
/*

*/

# EKS admin role with policy
resource "aws_iam_policy" "AmazonEKSAdminPolicy" {
  name        = "AmazonEKSAdminPolicy"
  description = "IAM policy to let users get admin role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "eks:*"
            ],
            "Resource": "*"
        },
        {
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": "eks.amazonaws.com"
                }
            }
        }
    ]
}
EOF
}
resource "aws_iam_role" "eks_admin_role" {
  name               = "eks-admin"
  assume_role_policy = jsonencode(
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRole",
            "Principal": {
                "AWS": "667656621301"
            },
            "Condition": {}
        }
    ]
}
)
}
resource "aws_iam_policy_attachment" "attach_eks_admin_policy" {
  name       = "eks-admin-attachment"
  roles      = [aws_iam_role.eks_admin_role.name]
  policy_arn = aws_iam_policy.AmazonEKSAdminPolicy.arn
}
/*
test role with aws iam get-role --role-name eks-admin, output is ok when:
...
"Principal": {
    "AWS": "arn:aws:iam::424432388155:root"
},
...
*/

# Create user admin with assume admin role
resource "aws_iam_user" "admin" {
  name = var.iamuseradmin
}
resource "aws_iam_policy" "AmazonEKSAssumeEKSAdminPolicy" {
  name        = "AmazonEKSAssumeEKSAdminPolicy"
  description = "admin assume role"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Resource": "arn:aws:iam::${var.accountid}:role/eks-admin"
        }
    ]
}
EOF
}
resource "aws_iam_user_policy_attachment" "attach_policy_to_user" {
  user       = var.iamuseradmin  
  policy_arn = aws_iam_policy.AmazonEKSAssumeEKSAdminPolicy.arn
}
/*
check role
aws sts assume-role \
  --role-arn arn:aws:iam::424432388155:role/eks-admin \
  --role-session-name manager-session \
  --profile iamuseradmin

user root user, update config
aws eks --region us-east-1 update-kubeconfig --name my-cluster
kubectl edit -n kube-system configmap/aws-auth
...
  mapRoles: |
    - rolearn: arn:aws:iam::424432388155:role/eks-admin
      username: eks-admin
      groups:
      - system:masters
...

add more assume profile link to source profile
[profile eks-admin]
role_arn = arn:aws:iam::424432388155:role/eks-admin
source_profile = iamuseradmin

then user assume profile to kubconfig
aws eks update-kubeconfig \
  --region us-east-1 \
  --name demo \
  --profile eks-admin

test kubectl config view --minify; kubectl auth can-i "*" "*"
*/