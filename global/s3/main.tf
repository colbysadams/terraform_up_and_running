provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "global/s3/terraform.tfstate"
  }
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "colbysadams-terraform-up-and-running-state"
  lifecycle {
    prevent_destroy = true
  }

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  hash_key = "LockID"
  name = "terraform-up-and-running-locks"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}
