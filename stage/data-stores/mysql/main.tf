provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "stage/data-stores/mysql/terraform.tfstate"
  }
}

module "stage_db" {
  source = "git@github.com:colbysadams/silver-guacamole.git//data-stores/mysql?ref=v0.0.1"
  db_name = "stagedb"
  db_password_secret_id = "stage/data-stores/mysql/admin"
}