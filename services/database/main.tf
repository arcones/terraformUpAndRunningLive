module "mysql" {
  source      = "git::git@github.com:arcones/terraformUpAndRunningModules.git//services//database"
  db_password = "${var.db_password}"
}
