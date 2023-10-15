terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

provider "terratowns" {
  endpoint = "http://localhost:4567/api"
  user_uuid="f14c65e6-a326-4d0d-ba12-0845d36c657c" 
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
  error_html_filepath = var.error_html_filepath
  index_html_filepath = var.index_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "How to play Factorio!"
  description = <<-DESCRIPTION
    Factorio is a game where players work to build and manage 
    factories on an alien planet, automating production processes 
    to efficiently generate resources while combating native 
    creatures and optimizing complex supply chains to ultimately 
    build a rocket to return home.
DESCRIPTION
  domain_name = "4jkd1kz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}