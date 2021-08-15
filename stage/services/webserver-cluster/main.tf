provider "aws" {
  version = "~> 2.0"
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "stage/services/webserver-cluster/terraform.tfstate"
  }
}

module "webserver_cluster" {
  source = "..\/..\/..\/..\/modules-repo\/services/webserver-cluster"
  cluster_name = "webservers-stage"
  db_remote_state_bucket = "colbysadams-terraform-up-and-running-state"
  db_remote_state_key = "stage/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  max_size = 2
  min_size = 2
}

//resource "aws_security_group_rule" "allow_testing_inbound" {
//  from_port = 12345
//  to_port = 12345
//  protocol = "tcp"
//  cidr_blocks = ["0.0.0.0/0"]
//  security_group_id = module.webserver_cluster.alb_security_group_id
//  type = "ingress"
//}