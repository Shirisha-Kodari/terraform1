terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket = "sr-remote-state-dev1"
    key    = "provisioners"
    region = "us-east-1"
    encrypt      = true  
    use_lockfile = true 
  }
  }


provider "aws" {
  # Configuration options
}