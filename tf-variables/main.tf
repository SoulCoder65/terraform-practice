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

resource "aws_instance" "terraform-varibale-demo-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  root_block_device {
    delete_on_termination = true
    tags = var.tags
    volume_type = var.ec2_config.v_type
    volume_size = var.ec2_config.v_size
  }
  tags = merge(var.tags, {
    Name : local.ProjectName
  })
}
