brew install warrensbox/tap/tfswitch
tfswitch -l
--> choose 1.0.11
terraform init
create account keybase -> setting create pgp key -> add to main.tf
create IAM user with MFA enabled and add them to groups

terraform output password | base64 --decode | keybase pgp decrypt.