terraform {
  required_providers {
    aws = {
            source  = "hashicorp/aws"
    version = "5.58.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}


resource "aws_vpc" "tf-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    "Name" : "tf-vpc"
  }
}

resource "aws_subnet" "subnet-groups" {
  vpc_id     = aws_vpc.tf-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  count      = 2
}

resource "aws_instance" "instance-groups" {
  ami = "ami-0ec0e125bb6c6e8ec"
  instance_type = "t2.micro"
  count = 4
  subnet_id = element(aws_subnet.subnet-groups[*].id,count.index % length(aws_subnet.subnet-groups))
}