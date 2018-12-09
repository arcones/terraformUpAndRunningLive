# Terraform Up & Running - Live

This project contains the exercises proposed in [Terraform Up & Running book (O'Reilly - Brikman)](https://www.terraformupandrunning.com/) 

## Prerequisites

The programs [aws-cli](https://aws.amazon.com/cli/) & [terraform](https://www.terraform.io/) should be installed in your machine prior to run it.

## Getting started

Go to any of the [services](services)' subfolders and run the standard terraform commands inside:

```hcl-terraform
terraform init
``` 
```hcl-terraform
terraform plan
``` 
```hcl-terraform
terraform apply
``` 

## State

The state is stored in an [S3 bucket](global/s3). This bucket is agnostic from environments used for the infrastructure.

## Environments

By default the backend configuration is set to write in the **dev** path of the S3 bucket, so when creating new environments, to isolate their state it should be provided a new path in the ```ìnit``` command, for example:

```hcl-terraform
terraform init  -backend-config="key=<nameOfNewEnvironment>/services/cluster/terraform.tfstate"
```

## Configuration of the modules

#### database

The single configuration key that [database](services/database) module uses is ```db_password``` so terraform will ask for it each time this module is used.
To avoid such question, there are several options:
1) To add the flag with the value in each terraform command, for example: ```terraform plan -var 'db_password=myPassword'```
2) To set an environment variable with the password. It should have the key TF_VAR_db_password
3) To add a ```tfvars``` file inside the [database](services/database) folder with the password 
 
#### cluster

[cluster](services/cluster) module is highly configurable. It is provided a ```tfvars``` file that will be loaded automatically with the values for **dev** environment.
To override **dev** values the easiest way is to create your own ```tfvars``` file and force the load of it in each terraform command, for example ```terraform plan -var-file=custom.tfvars``` 

## TODOs

- It seems like the cluster returns the same website whether in prod or in dev. The data should be different in each environment, so investigate and fix it.