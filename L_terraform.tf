terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket = "my-tfstate-remote-bucket"
    key    = "terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "my-tfstate-dynamodb-table"
    
  }
}
