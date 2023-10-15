# Terraform Beginner Bootcamp 2023 - Week 2

## Setting Up Terratowns Mock Web Server

### Working with Ruby
#### Bundler
Bundler is a package manager for ruby. It is the primary way to install rub packages (known as gems) for ruby.
#### Install Gems
You need to create a Gemfile and define your gems in that file
```ruby
source "http://rubygems.org"

gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
```
- Then you need to run the `bundle install` command
- This will install the gems won the system globally (unlike node which install packages in place in a older called node_modules)
- A gemfile.lock will be created to lock down the gem versions used in the this project
#### Executing Ruby Scripts in the Context of Bundler
- We have to use `bundle exec` to tell future ruby scripts to use the gems we install. This is the way we set context.
### Sinatra
https://sinatrarb.com
- Sinatra is a micro web framework for ruby to build web apps
- Great for mock or development servers or for very simple projects
- Can create a web server in a single file

### Runing the Web Server
- Execute the following:
```ruby
bundle install
bundle exec ruby server.rb
```
- All the code for our server is stored in the `server.rb` file

## Set Up Skeleton For Custom Terraform Provider



## Provider Block for Custom Terraform Provider
### Golang
- run a go file: `go run main.go`

1. `package main`
	- Defines itself as part of the `main` package, indicating it's an executable program.
2. `import "fmt"`
	- Imports the `fmt` package to use its functions for formatted I/O.
3. `func main()` 
	 - Defines the `main` function as the entry point of the program.
4. `fmt.Println("Hello, World!")`
	- Prints "Hello, World!" to the console when executed.


## Resource Skeleton

### TF_LOG
In Terraform, `TF_LOG` is an environment variable that controls the logging level. It helps in debugging by providing detailed logs of Terraform operations. Valid values are `TRACE`, `DEBUG`, `INFO`, `WARN`, and `ERROR`, with `TRACE` being the most verbose.
- https://developer.hashicorp.com/terraform/internals/debugging


## Implementing CRUD
https://developer.hashicorp.com/terraform/language/providers
> Terraform relies on plugins called providers for interaction with various services and APIs. It is necessary to declare and configure providers within Terraform configurations. The providers extend Terraform's capability by adding resource types and data sources. Providers have their own release and versioning system, separate from Terraform. Terraform Registry is a source of publicly available providers, and provides guidelines on how to use and install providers in Terraform configurations​[1](https://developer.hashicorp.com/terraform/language/providers)​.

