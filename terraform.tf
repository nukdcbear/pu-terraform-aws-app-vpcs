terraform {
  required_version = "> 0.12.0"
  required_providers {
    aws = "~> 2.62"
  }
  backend "s3" {
    bucket  = "dcb-tfe-bootcamp-tfstate"
    key     = "tfstates/pu-app-vpcs"
    region  = "us-east-2"
    encrypt = true
  }
}

provider "aws" {
  alias   = "aws-west"
  region  = "us-west-1"
}

provider "aws" {
  alias   = "aws-eu"
  region  = "eu-central-1"
}

provider "tls" {
  version = "~> 2.1"
}