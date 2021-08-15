provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "global/iam/terraform.tfstate"
  }
}

resource "aws_iam_user" "example" {
  for_each = toset(var.user_names)
  name = each.value
}