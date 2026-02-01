terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.10.2"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
