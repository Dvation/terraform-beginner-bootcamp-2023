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
