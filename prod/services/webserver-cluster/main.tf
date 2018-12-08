module "webserver_cluster" {
  source                 = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services/webserver-cluster"
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "teraform-up-and-running-arcones-state"
  db_remote_state_key    = "prod/services/data-stores/mysql/terraform.tfstate"
  instance_type          = "t2.micro"
  min_size               = 2
  max_size               = 10
}
