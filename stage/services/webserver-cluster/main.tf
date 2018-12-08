data "terraform_remote_state" "global_state" {
  backend = "s3"

  config {
    bucket = "teraform-up-and-running-arcones-state"
    key    = "global/s3/terraform.tfstate"
    region = "eu-central-1"
  }
}

module "webserver_cluster" {
  source                        = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services//webserver-cluster"
  cluster_name                  = "webservers-stage"
  db_remote_state_bucket        = "teraform-up-and-running-arcones-state"
  db_remote_state_key           = "stage/services/data-stores/mysql/terraform.tfstate"
  instance_type                 = "t2.micro"
  min_size                      = 2
  max_size                      = 2
  enable_autoscaling            = true
  alicia_cloudwatch_full_access = true
  user_names                    = ["${data.terraform_remote_state.global_state.user_names}"]
}

resource "aws_security_group_rule" "allow_testing_inbound_elb" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
