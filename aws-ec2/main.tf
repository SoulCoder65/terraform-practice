terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.58.0"
    }
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
