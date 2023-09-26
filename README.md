# Terraform Beginner Bootcamp 2023

## Feature Branches
**Create a new branch and check it out**
`git checkout -b 1_semantic_versioning`
- the `-b` tells git to create a new branch with the given name and immediately switch to that branch
- the first `push` you do will give you an error about *no upstream branch* - just execute the the command given in the error
	- *Explicit Push*
		- `git push origin [your branch name]`
		- tells git to push that specific branch to that specific remote
	- *Simple Push*
		- `git push`
		- git will push to the set upstream branch for your current branch, if you've set it:
			- `git branch --set-upstream-to=origin/[branch name]`
		- If not set and the `push.default` config is set to default (matching), Git will push branches to the remote that have matching names. In this mode, if a branch of the same name <u>doesn't exist</u> on the remote or the names don't match, the push will fail.

**Merging the branch**
First, checkout the branch you want to merge into (typically 'main')
`git checkout main`
Then run the merge command where branch name is the name of the branch merging into main
`git merge <branch name>`
- Once merged, you can delete the branch

**Other Commands**
`git fetch origin`
- updates your local repo if there are new/deleted branches in the remote repo (often referred to as '*origin*') 
- gets the latest state of all branches and commits
- crucial to have the latest changes from remote before merging
- *important command to run before attempting a merge*

## Semantic Versioning
https://semver.org/

The general format:
**MAJOR.MINOR.PATCH**, rg. `1.0.1`
 - **MAJOR** version when you make incompatible API changes 
 - **MINOR** version when you add functionality in a backward compatible manner
 - **PATCH** version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changes 
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed to refer to the latest install CLI instructions via Terraform documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorlals/aws-get-started/lnstall-cll)

### Considerations for Linux Distribution
Please consider checking your Linux Distrubtion and change accordingly to distrubtion needs.
[How To Check OS Version in Linux](https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS version:
```
$ cat /etc/os-release
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSI0N_ID="22.04"
VERSI0N="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL=Mhttps://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```


###  Refactoring into Bash Scripts
While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

•	This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml))tidy.
•	This allow us an easier to debug and execute manually Terraform CLX install
•	This will allow better portablity for other projects that need to install Terraform CLI.

#### Shebang
A Shebang (prounced Sha-bang) tells the bash script what program that will interpet the script, eg. ChatGPT recommended this format for bash: '#!/usr/bin/env bash'
 - for portability for different OS distributions
 - will search the user's PATH for the bash executable

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

https://en.wikipedia.org/wiki/Shebang_(Unix)


## Execution Considerations
When executing the bash script we can use the `./` shorthand notiation to execute the bash script.
e.g. `./bin/install_terraform_cli`
If we are using a script in .gitpod.yml we need to point the script to a program to interpert it.
e.g. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permissions for the script to be executable at the user mode.
```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:
```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

### Gitpod Lifecycle (Before, Init, Command)
We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks


## Environment Variables

- Typing `env` in bash will show all environment variables current set
- `env | grep <string>` can filter for a specific env var
- `echo $ENV_VAR` will print the value of a specific env var
- `export ENV_VAR='VALUE'` will set an env var, `unset` removes it
- Simply running `ENV_VAR='VALUE'` temporarily sets an env var for that session
	- bash profiles can be used for permanent assignments

### GitPod Env Vars (Persistent)
`gp env HELLO='world'`
- Future workspaces launched will set the env vars for all bash terminals 

#### Env Var Reference
- Create a `.env.example` file in the root
- Set the variable in the file, e.g. `PROJEC_ROOT='/workspace/terraform-beginner-bootcamp-2023'`
- This will let other users know what the env var is set to


# Terraform Basics
- Run `terraform` on its own to show a list of all terraform commands
- `terraform init` downloads the binaries for the terraform providers to the `.terraform` folder
- `terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used 
- `terraform.tfstate.backup` is the previous state file

# Terraform Registry
Contains providers and modules from [registry.terraform.io](https://registry.terraform.io/)
# Outputs
```hcl
output "instance_ip_addr" {
  value = aws_instance.server.private_ip
}
```
- Will output some value after running a `terraform apply`
- Can manually run `terraform output` to see output values after having already run `terraform apply`


# Terraform AWS Provider Authentication
Configuration for the AWS Provider can be derived from several sources, which are applied in the following order:

1. Parameters in the provider configuration
2. Environment variables
3. Shared credentials files
4. Shared configuration files
5. Container credentials
6. Instance profile credentials and region

# Terraform Errors
- `The following dependency selections recorded in the lock file are inconsistent with the current configuration`
	- Provider configuration has changed since the last `terraform init`, running `terraform init -upgrade` will update the new provider configuration. 

# Terraform Cloud Pricing
https://www.hashicorp.com/products/terraform/pricing
Free up to 500 resources per month
No credit card required

# Terraform Cloud Workspace
**Workspace:** A workspace contains your Terraform configuration (infrastructure as code), shared variable values, your current and historical Terraform state, and run logs.
**Project:** Projects let you organize your workspaces into groups.
- Each project has a separate permissions set.
	- Project-level permissions are more granular than organization-level permissions
	- Project-level permissions are more specific than individual workspace-level grants.
	- [!] **Note:** Projects are available to all users, but managing project permissions requires the Terraform Cloud **Standard** Edition.
	- [i] When deciding how to structure your projects, consider which groups of resources need distinct access rules. You may wish to define projects by business units, departments, subsidiaries, or technical teams.

# Terraform Token
[Create a token](https://app.terraform.io/app/settings/tokens) for authenticating terraform cloud via the CLI using `terraform login` which is required when using the cloud terraform block e.g.:
```hcl
terraform {
  cloud {
    organization = "dvation"

    workspaces {
      name = "terra-house-1"
    }
  }
}
```

> **Migrate state to Terraform Cloud**
> https://developer.hashicorp.com/terraform/tutorials/cloud/cloud-migrate

# Terraform Cloud Login with Gitpod
Running `terraform login` generates a menu that doesn't render correctly in gitpod. 
**Workaround:** 
- generate a [token](https://app.terraform.io/app/settings/tokens) 
- create and open:
	- `touch /home/gitpod/.terraform.d/credential.tfrc.json`
	- `open /home/gitpod/.terraform.d/credential.tfrc.json`
- Add your token to the file:
```json
{
 "credentials": {
   "app.terraform.io": {
     "token": "xxxxxx.atlasv1.zzzzzzzzzzzzz"
     }
  }
}
```
- Run `terraform init` after setting credentials
- Should terraform migrate your existing state? **YES**

# Automate Terraform Cloud Credentials
- We used ChatGPT to generate a script (`bin/generate_tfrc_credentials`) to create a credentials file for terraform cloud
- We used a 30 day token and assigned it to the env var `TERRAFORM_CLOUD_TOKEN`, which was used in the script
Example of the credentials file contents:
```
{
  "credentials": {
    "app.terraform.io": {
      "token": "xxxxxx.atlasv1.zzzzzzzzzzzzz"
      }
   }
}
```

# Terraform Alias
- `open ~/.bash_profile` is where we can set bash configurations
- add the line `alias tf="terraform"` so that running `tf` in bash will call `terraform`
- bash needs to be reloaded to take affect: `source ~/.bash_profile`
- use ChatGPT to generate a bash script to automate this (`/bin/set_tf_alias`) 
- update `.gitpod.yml` to auto-execute on workspace start