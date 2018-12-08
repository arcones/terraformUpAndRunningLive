module "mysql" {
  source      = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services//data-stores/mysql"
  db_password = "${var.db_password}"
}
