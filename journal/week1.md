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

