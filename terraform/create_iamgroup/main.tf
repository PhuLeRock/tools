#create IAM group user and policy for this group
resource "aws_iam_group" "dynamoadmin_group" {
  name = var.groupname
  path = "/"
}
resource "aws_iam_group_policy" "dynamoadmin_policy" {
  name  = "aduro_dynamoadmin"
  group = aws_iam_group.dynamoadmin_group.name

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "dynamodb:*",
            "Resource": "*"
        }
    ]
})
}

# Add user to group
resource "aws_iam_user_group_membership" "users" {
  count = length(var.username)
  user = element(var.username, count.index)
  groups = [var.groupname,]
}



# 
