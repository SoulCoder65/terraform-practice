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

data "aws_ami" "name" {
  most_recent = true
  owners = ["amazon"]
}

output "aws_ami_name" {
  value = data.aws_ami.name.id
}

# AZ
data "aws_availability_zones" "name" {
  state = "available"
}

output "aws_availability_zones_names" {
  value = data.aws_availability_zones.name.names
}

# To get current account details
data "aws_caller_identity" "details" {
  
}

output "aws_caller_identity_details" {
  value = data.aws_caller_identity.details
}

resource "aws_instance" "terraform-data-source-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  tags          = var.tags
}
