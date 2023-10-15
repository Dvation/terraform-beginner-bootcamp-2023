terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  cloud {
    organization = "dvation"
    workspaces {
      name = "terra-house-1"
    }
  }  
}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_factorio_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.factorio.public_path
  content_version = var.factorio.content_version
}

resource "terratowns_home" "home" {
  name = "How to play Factorio!"
  description = <<DESCRIPTION
Factorio is a game where players work to build and manage 
factories on an alien planet, automating production processes 
to efficiently generate resources while combating native 
creatures and optimizing complex supply chains to ultimately 
build a rocket to return home.
DESCRIPTION
  domain_name = module.home_factorio_hosting.domain_name
  town = "missingo"
  content_version = var.factorio.content_version
}

module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.payday.public_path
  content_version = var.payday.content_version
}

resource "terratowns_home" "home_payday" {
  name = "Making your Payday Bar"
  description = <<DESCRIPTION
Finally, it's payday! Can't wait to see that paycheck hit my account. 
Hard work pays off, literally!
DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "missingo"
  content_version = var.payday.content_version
}