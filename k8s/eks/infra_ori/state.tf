

# this is second steps
terraform {
 backend "s3" {
   bucket         = "phulerock-terraform-state"
   key            = "state/terraform.tfstate"
   region         = "ap-southeast-1"
   encrypt        = true
   kms_key_id     = "alias/terraform-bucket-key"
   dynamodb_table = "terraform-state"
 }
}
