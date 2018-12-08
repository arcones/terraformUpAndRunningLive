terraform {
  backend "s3" {
    bucket  = "teraform-up-and-running-arcones-state"
    region  = "eu-central-1"
    key     = "global/s3/terraform.tfstate"
    encrypt = true
  }
}

provider "aws" {
  region = "eu-central-1"
}
