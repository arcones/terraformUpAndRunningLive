data "terraform_remote_state" "global_state" {
  backend = "s3"

  config {
    bucket = "teraform-up-and-running-arcones-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "webserver_cluster" {
  source                        = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services/webserver-cluster"
  cluster_name                  = "webservers-prod"
  db_remote_state_bucket        = "teraform-up-and-running-arcones-state"
  db_remote_state_key           = "prod/services/data-stores/mysql/terraform.tfstate"
  instance_type                 = "t2.micro"
  min_size                      = 2
  max_size                      = 10
  enable_autoscaling            = false
  alicia_cloudwatch_full_access = false
  user_names                    = "${data.terraform_remote_state.global_state.user_names}"
  enable_new_user_data          = false
}
