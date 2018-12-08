module "mysql" {
  source      = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services//data-stores/mysql?ref=0.0.1"
  db_password = "${var.db_password}"
}
