provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "prod/data-stores/mysql/terraform.tfstate"
  }
}

module "prod_db" {
  source = "..\/..\/..\/..\/modules-repo\/data-stores/mysql"
  db_name = "proddb"
  # just re-use the staging thing
  db_password_secret_id = "stage/data-stores/mysql/admin"
}