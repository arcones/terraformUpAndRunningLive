terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "prod/services/data-stores/mysql/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}
