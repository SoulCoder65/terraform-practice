terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
  }
  backend "s3" {
    bucket = "tf-demo-bucket-11fa429b2693e243"
    key = "backend.tfstate"
    region = "ap-south-1"
  }
}


provider "aws" {
  region = var.region
}

resource "aws_instance" "terraform-demo-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}
