terraform {
  backend "s3" {
    bucket  = "terraform-up-and-running-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "dev/services/cluster/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}