provider "aws" {
  region               = "us-east-1"
}

terraform {
  backend "s3" {
    bucket             = "new-bucket-ansible-terraform"
    key                = "ansible-terraform/terraform_remote-state_file"
    region             = "us-east-1"
    dynamodb_table     = "new_dynamodb_table"
  }
}