terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.5"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
