terraform {
  backend "s3" {
    bucket  = "tf-arcones-state"
    region  = "eu-central-1"
    encrypt = true
    key     = "dev/services/database/terraform.tfstate"
  }
}

provider "aws" {
  region = "eu-central-1"
}
