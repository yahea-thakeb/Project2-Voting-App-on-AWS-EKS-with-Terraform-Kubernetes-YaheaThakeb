provider "aws" {
  region = var.availability_zone
}

terraform {
  backend "s3" {
    bucket         = "yahea_thakeb-project1-terraform-state"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "yahea_thakeb-terraform-state-block"
  }
}