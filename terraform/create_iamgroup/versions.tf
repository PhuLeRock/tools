terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 2.0.0"
    }
  }
  required_version = ">= 1.0.4"
}
provider "aws" {
  profile = var.profile
  region = var.region
}