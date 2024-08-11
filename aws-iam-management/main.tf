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


locals {
  users_data = yamldecode(file("./users.yaml")).users
  users_role_pair = flatten([for user in local.users_data : [for role in user.roles : {
    username : user.username
    role : role
  }]])
}

output "output" {
  value = local.users_role_pair
}


# Creating users
resource "aws_iam_user" "tf-users-group" {
  for_each = toset(local.users_data[*].username)
  name     = each.value
}

# Creating profile and passwords
resource "aws_iam_user_login_profile" "tf-users-profile" {
  for_each        = aws_iam_user.tf-users-group
  user            = each.value.name
  password_length = 12

  lifecycle {
    ignore_changes = [
      password_length,
      password_reset_required,
      pgp_key,
    ]
  }

}

resource "aws_iam_user_policy_attachment" "main" {
 for_each = {
    for pair in local.users_role_pair:
    "${pair.username}-${pair.role}" => pair
 }
  user       = aws_iam_user.tf-users-group[each.value.username].name
  policy_arn = "arn:aws:iam::aws:policy/${each.value.role}"
}