# AWS VPC CREATION
resource "aws_vpc" "tf-vpc-nginx" {
  cidr_block = "10.0.0.0/16"
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc"
    }
  )
}


# AWS PRIVATE SUBNET
resource "aws_subnet" "tf-vpc-nginx-private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.tf-vpc-nginx.id
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc-private-subnet"
    }
  )
}

# AWS PUBLIC SUBNET
resource "aws_subnet" "tf-vpc-nginx-public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.tf-vpc-nginx.id
  tags = merge(
    var.tags,
    {
      Name = "tf-vpc-public-subnet"
    }
  )
}

# AWS INTERNT GATEWAY
resource "aws_internet_gateway" "tf-nginx-igw" {
  vpc_id = aws_vpc.tf-vpc-nginx.id
  tags = merge(
    var.tags,
    {
      Name = "tf-igw"
    }
  )
}

# AWS ROUTE TABLE
resource "aws_route_table" "tf-nginx-route-table" {
  vpc_id = aws_vpc.tf-vpc-nginx.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tf-nginx-igw.id
  }
  tags = merge(
    var.tags,
    {
      Name = "tf-route-table"
    }
  )
}

# AWS ROUTE ASSOCIATION
resource "aws_route_table_association" "tf-nginx-route-association" {
  route_table_id = aws_route_table.tf-nginx-route-table.id
  subnet_id      = aws_subnet.tf-vpc-nginx-public-subnet.id

}
