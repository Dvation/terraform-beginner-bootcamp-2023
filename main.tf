terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
}

# provider "terratowns" {
#   endpoint = "https://terratowns.cloud/api"
#   user_uuid="f14c65e6-a326-4d0d-ba12-0845d36c657c" 
#   token="534ec38a-e038-4f89-9545-f2e0d3bba77c" 
# }

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version = var.content_version
#}

resource "terratowns_home" "home" {
  name = "How to play Factorio!"
  description = <<DESCRIPTION
Factorio is a game where players work to build and manage 
factories on an alien planet, automating production processes 
to efficiently generate resources while combating native 
creatures and optimizing complex supply chains to ultimately 
build a rocket to return home.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}