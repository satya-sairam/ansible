provider "aws" {
  region               = "us-east-1"
}

terraform {
  backend "s3" {
    bucket             = "terraform-my-first-bucket"
    key                = "ansible-terraform/terraform_remote-state_file"
    region             = "us-east-1"
    dynamodb_table     = "my-dynamodb-table-terraform"
  }
}