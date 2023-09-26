terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }
  }
#   cloud {
#     organization = "dvation"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }  
}

provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}
