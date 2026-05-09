terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.12.1"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
