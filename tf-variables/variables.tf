locals {
  ProjectName = "terraform-demo"
}

variable "region" {
  description = "value of region"
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  type = string
  #   default     = "t2.micro"
  description = "Type of AWS EC2 instance"
  validation {
    condition     = var.instance_type == "t2.micro" || var.instance_type == "t3.micro"
    error_message = "Only t2 and t3 micro are allowed"
  }
}

variable "ami" {
  type        = string
  default     = "ami-0ec0e125bb6c6e8ec"
  description = "ami of aws ec2 instance"
}

variable "tags" {
  type = map(string)
  default = {
    "Environment" = "dev"
    "Project"     = "terraform-demo"
  }
  description = "Tags to apply to the EC2 instances"
}

variable "ec2_config" {
  type = object({
    v_size = number
    v_type = string
  })
  default = {
    v_size = 20
    v_type = "gp2"
  }
}
