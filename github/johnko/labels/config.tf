terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "6.11.1"
    }
  }
}

# Configure the GitHub Provider
provider "github" {}
