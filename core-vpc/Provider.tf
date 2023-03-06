terraform {
  required_version = ">= 1.0" # which means any version equal & above 0.14 like 0.15, 0.16 etc and < 1.xx
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  /*
  backend "s3" {
    bucket = "my-terraform-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-terraform-state-lock"
  }
  */
}

provider "aws" {
    region = "us-east-1"
  
}
