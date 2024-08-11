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

# AWS VPC CREATION
resource "aws_vpc" "tf-vpc" {

  cidr_block = "10.0.0.0/16"
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc"
    }
  )
}

# AWS PRIVATE SUBNET
resource "aws_subnet" "tf-vpc-private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.tf-vpc.id
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc-private-subnet"
    }
  )
}

# AWS PUBLIC SUBNET
resource "aws_subnet" "tf-vpc-public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.tf-vpc.id
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc-public-subnet"
    }
  )
}

# AWS INTERNT GATEWAY
resource "aws_internet_gateway" "tf-igw" {
  vpc_id = aws_vpc.tf-vpc.id
  tags = merge(
    var.tags,
    {
      Name = "tf-igw"
    }
  )
}

# AWS ROUTE TABLE
resource "aws_route_table" "tf-route-table" {
  vpc_id = aws_vpc.tf-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-igw.id
  }
  tags = merge(
    var.tags,
    {
      Name = "tf-route-table"
    }
  )
}

# AWS ROUTE ASSOCIATION
resource "aws_route_table_association" "tf-route-association" {
  route_table_id = aws_route_table.tf-route-table.id
  subnet_id      = aws_subnet.tf-vpc-public-subnet.id

}

# AWS EC2
resource "aws_instance" "tf-instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = aws_subnet.tf-vpc-public-subnet.id
  tags          = merge(
    var.tags,
    {
        Name:"tf-instance"
    }
  )

}
