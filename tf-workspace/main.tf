terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.58.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "random_id" "random_s3_bucket_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "tf-demo-bucket-soul" {
  bucket = "tf-demo-bucket-${terraform.workspace}-${random_id.random_s3_bucket_id.hex}"
}