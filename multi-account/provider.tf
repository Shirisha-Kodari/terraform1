
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.98.0"
    }
  }
}

provider "aws" {
  # Configuration options
  alias = "prod"
  profile = "prod"
}

provider "aws" {
  # Configuration options
  alias = "dev"
  profile = "dev"
}
