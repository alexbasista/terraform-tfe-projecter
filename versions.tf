terraform {
  required_version = ">= 1.6.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.70"
    }
  }
}