terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.53.0"
    }
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.7.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "3.62.0"
    }
  }
}
