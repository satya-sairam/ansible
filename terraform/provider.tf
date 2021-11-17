provider "aws" {
  region               = "us-east-1"
}

terraform {
  backend "s3" {
    bucket             = "my-ansible-terraform-bucket"
    key                = "ansible/terraform.tfstate"
    region             = "us-east-1"
    dynamodb_table     = "new_dynamodb_table"
  }
}