# Terraform Up & Running - Live

This project contains the exercises proposed in [Terraform Up & Running book](https://www.terraformupandrunning.com/) 

## Prerequisites

The programs [aws-cli](https://aws.amazon.com/cli/) & [terraform](https://www.terraform.io/) should be installed in your machine prior to run it.

## State storage

The state will be stored in an **S3 bucket**. This bucket is agnostic from environments used for the infrastructure.

**The first time** you run the project, will be needed to comment out the ``terraform`` block in [config file](global/s3/config.tf) and then run there:
```hcl-terraform
terraform init && terraform apply -auto-approve
``` 
Then uncomment the ``terraform`` block and run ``terraform init -force-copy`` so the state file of the S3 is stored in the S3 itself.

It will be created also some AWS users that will have certain permissions over the infrastructure.

## Environments

By default the backend configuration is set to write in the **dev** path of the S3 bucket, so when creating new environments, to isolate their state it should be provided a new path in the ```ìnit``` command of each service, for example:

```hcl-terraform
terraform init  -backend-config="key=<nameOfNewEnvironment>/services/cluster/terraform.tfstate"
```

To the question of copying existing states among backends, answer 'No'. 

Otherwise the state of the different environment can be mixed and overwritten among themselves, creating a huge mess.

## Modules configuration

#### database

The single configuration key that [database](services/database) module uses is ```db_password``` so terraform will ask for it each time this module is used.
To avoid such question, there are several options:
1) To add the flag with the value in each terraform command, for example: ```terraform plan -var 'db_password=myPassword'```
2) To set an environment variable with the password. It should have the key TF_VAR_db_password
3) To add a ```tfvars``` file inside the [database](services/database) folder with the password 
 
#### cluster

[cluster](services/cluster) module is highly configurable. It is provided a ```tfvars``` file that will be loaded automatically with the values for **dev** environment.
To override **dev** values the easiest way is to create your own ```tfvars``` file and force the load of it in each terraform command, for example ```terraform plan -var-file=custom.tfvars``` 

## Infrastructure management

Go to any of the [services](services)' subfolders and run the standard terraform commands inside to manage the infrastructure (don't forget to override the ```backend-config``` if the environment is not dev)

## Tests

The [cluster](services/cluster) will output the load balancer URL when finishes its ```terraform apply``` command. This URL should return a 200 HTTP response code and the content of the index.html file created by one of the scripts contained in [this folder of modules repo](https://github.com/arcones/terraformUpAndRunningModules/tree/master/services/cluster/asg)

## TODOs

- It seems like the cluster returns the same website whether in prod or in dev. The data should be different in each environment, so investigate and fix it.