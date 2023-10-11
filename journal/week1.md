# Terraform Beginner Bootcamp 2023 - Week 1

## Terraform and Input Variables

### Terraform Cloud Variables
We can set two types:
- Environment Variables - variables you would set in your bash profile
- Terraform Variables: variables you would normally set in your tfvars file

Terraform Cloud variables can be set as _sensitive_ so they are not shown visibly in the UI.

### Loading Terraform Input Variables
- Can use the `-var` flag to set an input variable or override a variable in tfvars
- e.g. `terraform -var user_uuid="my-user-id"`


### var-file flag


### terraform.tvfars
- The default file to load in terraform variables in bulk

### auto.tfvars

### Order of Terraform Variables

## Terraform Import / Configuration Drift
`terraform import` can be used to manage resources that were not created by terraform (or are not currently in the state file for whatever reason). Terraform v1.5.0+ also supports using *import blocks* instead of using the import command line parameter. 

In the AWS Registry on the Terraform site > documentation > (AWS Service), there will be an **Import** section (typically on the bottom) if the resource can be imported (apparently not all resources can be imported). 

Generally, the command is:
`terraform import resource_block.resource_block_name aws_resource_id`

We can find *Attribute References* in the same documentation page for the service. These attributes can be referenced in other parts of our terraform (E.g.  `bucket` is reference so we can reference the name using `aws_s3_bucket.bucket_name.arn`)

Similarly, *Argument References* are in the resource block but can also be referenced elsewhere (E.g. `aws_s3_bucket.bucket_name.bucket`)

## Terraform Modules
Terraform Module Structure: https://developer.hashicorp.com/terraform/language/modules/develop/structure

Terraform modules can be imported from a variety of sources including github, s3 buckets or the terraform registry directly: https://developer.hashicorp.com/terraform/language/modules/sources

### Example Module Imports
```
# Local
module "consul" {
  source = "./consul"
}

# Registry
module "consul" {
  source = "hashicorp/consul/aws"
  version = "0.1.0"
}

```

> [!info]
> Empty provider blocks are not needed in current versions of terraform
> ```
> provider "aws" {
>  # Configuration options> 
> }
>```

## Terraform Refresh
Terraform **refresh** reconciles the terraform state with the actual infrastructure by *updating the state file to reflect the current state of the infrastructure* as per the provider's API:
https://developer.hashicorp.com/terraform/cli/commands/refresh
- this also updates **outputs**
- primarily used to detect **drift**
- makes no changes to infrastructure 
> [!warning] Deprecation Warning
> `terraform refresh` is deprecated starting with Terraform v0.15 and has been rolled into the `terraform plan` command, however the `refresh` command is still available.


## S3 Static Website Hosting
The AWS provider requires an `aws_s3_bucket_website_configuration` resource: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_website_configuration


> [!NOTE] ChatGPT
> Careful using AI for Terraform as changes occur frequently with providers and the model may not  have the most up-to-date information

We can use `aws_s3_object` to have terraform upload files (e.g. index.html) to our bucket: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object

### Terraform References to Named Values
How to call various paths when working with files in terraform:
https://developer.hashicorp.com/terraform/language/expressions/references
Specifically, https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info

- [`path.module`](https://developer.hashicorp.com/terraform/language/expressions/references#path-module) is the filesystem path of the module where the expression is placed. We do not recommend using `path.module` in write operations because it can produce different behavior depending on whether you use remote or local module sources. Multiple invocations of local modules use the same source directory, overwriting the data in `path.module` during each call. This can lead to race conditions and unexpected results.
- [](https://developer.hashicorp.com/terraform/language/expressions/references#)[`path.root`](https://developer.hashicorp.com/terraform/language/expressions/references#path-root) is the filesystem path of the root module of the configuration.
- [](https://developer.hashicorp.com/terraform/language/expressions/references#)[`path.cwd`](https://developer.hashicorp.com/terraform/language/expressions/references#path-cwd) is the filesystem path of the original working directory from where you ran Terraform before applying any `-chdir` argument. This path is an absolute path that includes details about the filesystem structure. It is also useful in some advanced cases where Terraform is run from a directory other than the root module directory. We recommend using `path.root` or `path.module` over `path.cwd` where possible.
- [](https://developer.hashicorp.com/terraform/language/expressions/references#)[`terraform.workspace`](https://developer.hashicorp.com/terraform/language/expressions/references#terraform-workspace) is the name of the currently selected [workspace](https://developer.hashicorp.com/terraform/language/state/workspaces).

This is particularly useful for when *working with modules* so you don't need to hard code paths.
- Instead of: `source = "/workspace/terraform-beginner-bootcamp-2023/public/index.html"`
- Use: `source = "${path.root}/public/index.html"`
### Terraform Console
`terraform console` provides an interactive console for evaluating and inspecting Terraform expressions. It's useful for experimenting with expressions and viewing the values of your Terraform variables and state.
```
$ terraform console
> path.root
  "."
```

### eTags
If you don't change the configuration of any resource block attributes, terraform won't know anything changed.
- This is important when deploying static s3 website buckets because terraform won't know when an html file has changed

Terraform deals with this using `etags`. When the `etag` changes, terraform knows to update the file:
```
etag = filemd5("path/to/file")
```


## Terraform Functions
Terraform has a variety of built in functions that can be called from within expression:
https://developer.hashicorp.com/terraform/language/functions


## Content Delivery Network
- Resource: [aws_cloudfront_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution)
- Amazon CloudFront introduces [Origin Access Control](https://aws.amazon.com/blogs/networking-and-content-delivery/amazon-cloudfront-introduces-origin-access-control-oac/) (OAC)
- Resource: [aws_cloudfront_origin_access_control](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control)
- Resource: [aws_s3_bucket_policy](https://registry.terraform.io/providers/rgeraskin/aws3/latest/docs/resources/s3_bucket_policy)

[Terraform Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)
> A `data` block requests that Terraform read from a given data source ("aws_ami") and export the result under the given local name ("example"). The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.

- Data Source: [aws_caller_identity](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity)
	- Can be used to get our account ID
```hcl
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```
### Locals
Useful to reference cloud resources without importing them
```hcl
locals {
  s3_origin_id = "myS3Origin"
}
```

### Content Type
The `content_type` attribute needs to be specified for serving an html file from an S3 bucket otherwise the file will get downloaded instead of rendered by the browser:
```
resource "aws_s3_object" "error_html" {
  ...
  content_type = "text/html"
}
```

### Working with JSON
- https://developer.hashicorp.com/terraform/language/functions/jsonencode
- https://developer.hashicorp.com/terraform/language/syntax/json
