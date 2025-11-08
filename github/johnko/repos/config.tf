terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.7.3"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
