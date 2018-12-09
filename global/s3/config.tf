terraform {
  backend "s3" {
    bucket  = "terraform-up-and-running-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "global/s3/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}
