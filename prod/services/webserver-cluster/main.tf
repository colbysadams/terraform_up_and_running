provider "aws" {
  version = "~> 2.0"
  region = "us-east-2"
}

terraform {
  backend "s3" {
    key = "prod/services/webserver-cluster/terraform.tfstate"
  }
}

module "webserver_cluster" {
  source = "git@github.com:colbysadams/silver-guacamole.git//services/webserver-cluster?ref=v0.0.1"
  cluster_name = "webservers-prod"
  db_remote_state_bucket = "colbysadams-terraform-up-and-running-state"
  db_remote_state_key = "prod/data-stores/mysql/terraform.tfstate"
  instance_type = "t2.micro"
  max_size = 10
  min_size = 2
}

resource "aws_autoscaling_schedule" "scale_out_during_business_hours" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name = "scale-out-during-business-hours"
  min_size = 2
  max_size = 10
  desired_capacity = 10
  recurrence = "0 9 * * *"
}

resource "aws_autoscaling_schedule" "scale_in_at_night" {
  autoscaling_group_name = module.webserver_cluster.asg_name
  scheduled_action_name = "scale-in-at-night"
  min_size = 2
  max_size = 10
  desired_capacity = 2
  recurrence = "0 17 * * *"
}