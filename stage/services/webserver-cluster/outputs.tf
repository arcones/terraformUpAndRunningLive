output "elb_dns_name" {
  value = "${module.webserver_cluster.elb_dns_name}"
}

output "script_used" {
  value = "${module.webserver_cluster.script_used}"
}