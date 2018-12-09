data "terraform_remote_state" "global_state" {
  backend = "s3"

  config {
    bucket = "terraform-up-and-running-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "webserver_cluster" {
  source                        = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services//cluster"
  cluster_name                  = "${var.cluster_name}"
  db_remote_state_bucket        = "${var.db_remote_state_bucket}"
  db_remote_state_key           = "${var.db_remote_state_key}"
  instance_type                 = "${var.instance_type}"
  min_size                      = "${var.min_size}"
  max_size                      = "${var.max_size}"
  enable_autoscaling            = "${var.enable_autoscaling}"
  alicia_cloudwatch_full_access = "${var.alicia_cloudwatch_full_access}"
  user_names                    = ["${data.terraform_remote_state.global_state.user_names}"]
  enable_new_user_data          = "${var.enable_new_user_data}"
  open_testing_port             = "${var.open_testing_port}"
}
