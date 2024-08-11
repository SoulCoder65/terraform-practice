
# Terraform AWS VPC Module

This Terraform module creates an AWS Virtual Private Cloud (VPC) with public and private subnets, an Internet Gateway, and a route table. It is designed to be flexible and customizable according to your infrastructure needs.

## Features

- Create a VPC with customizable CIDR blocks.
- Create public and private subnets across different availability zones.
- Attach an Internet Gateway to the VPC (if public subnets are present).
- Create and associate a route table with the public subnets.

## Usage

```hcl
provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-test-vpc"
  }

  subnet_config = {
    "public_subnet-1" = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-south-1a"
      public     = true
    }
    "public_subnet-2" = {
      cidr_block = "10.0.2.0/24"
      az         = "ap-south-1a"
      public     = true
    }
    "private_subnet" = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1b"
    }
  }
}
```

## Inputs

| Name           | Description                                | Type   | Default   | Required |
|----------------|--------------------------------------------|--------|-----------|----------|
| `vpc_config`   | Configuration for the VPC, including CIDR block and name. | `map`  | n/a       | yes      |
| `subnet_config`| Configuration for the subnets, including CIDR blocks, availability zones, and whether they are public or private. | `map`  | n/a       | yes      |

## Outputs

| Name               | Description                                               |
|--------------------|-----------------------------------------------------------|
| `vpc_id`           | The ID of the created VPC.                                 |
| `vpc_cidr_block`   | The CIDR block of the created VPC.                         |
| `public_subnet_ids`| The IDs of the created public subnets.                     |
| `private_subnet_ids`| The IDs of the created private subnets.                   |
| `vpc_name`         | The name of the created VPC.                               |
| `internet_gateway_id`| The ID of the Internet Gateway, if created.              |
| `route_table_id`   | The ID of the route table associated with the public subnets, if created. |

## Requirements

- Terraform >= 0.12
- AWS provider >= 2.0

## Example

To create a VPC with public and private subnets:

```hcl
module "vpc" {
  source = "./modules/vpc"

  vpc_config = {
    cidr_block = "10.0.0.0/16"
    name       = "my-example-vpc"
  }

  subnet_config = {
    "public_subnet-1" = {
      cidr_block = "10.0.0.0/24"
      az         = "ap-south-1a"
      public     = true
    }
    "private_subnet" = {
      cidr_block = "10.0.1.0/24"
      az         = "ap-south-1b"
    }
  }
}
```

## License

This module is licensed under the MIT License.
