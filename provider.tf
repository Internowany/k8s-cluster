terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
  backend "s3" {
    bucket         = "tf-terraform-state" # set your bucket
    key            = "global/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "tf-terraform-locks" # set your db
    encrypt        = true
  }
}

provider "aws" {
  region = var.REGION
}
