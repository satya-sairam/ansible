provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket           = "terraform-ansible-bucket"
    key              = "sample/terraform.state"
    region           = "us-east-1"
    dynamodb_table   = "my_dynamoDB_table"
  }
}