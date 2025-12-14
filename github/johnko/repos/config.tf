terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.9.0"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
