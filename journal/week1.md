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