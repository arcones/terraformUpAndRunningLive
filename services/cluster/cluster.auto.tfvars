cluster_name = "webservers-dev"
db_remote_state_bucket  = "tf-arcones-state"
db_remote_state_key = "dev/services/database/terraform.tfstate"
instance_type = "t2.micro"
min_size = 2
max_size = 2
enable_autoscaling = true
alicia_cloudwatch_full_access = true
enable_new_user_data = true
open_testing_port = true