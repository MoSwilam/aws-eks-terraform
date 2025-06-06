provider "aws" {
  region = local.region
}

terraform {
  required_version = "~> 1.11.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.92.0"
    }
  }
}