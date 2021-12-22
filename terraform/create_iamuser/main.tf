#create IAM user

resource "aws_iam_user" "users" {
  count = length(var.username)
  name = element(var.username, count.index)
}
resource "aws_iam_user_login_profile" "users" {
  count = length(var.username)
  user    = element(var.username, count.index)
  password_reset_required = true
  pgp_key = "keybase:leroiuotmi"
}

# Add user to group
resource "aws_iam_user_group_membership" "users" {
  count = length(var.username)
  user = element(var.username, count.index)
  groups = var.groupname
}



# 
