brew install warrensbox/tap/tfswitch
tfswitch -l
--> choose 1.0.11
terraform init

create IAM group and policy for that group, then add users to the group. 
nothing in output.tf
Note: groups in resource "aws_iam_user_group_membership" must be type list, so it need to place in [zyz, ]

