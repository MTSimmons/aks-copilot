terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0.0"  # Latest stable version as of now
        }
    }
}

provider "azurerm" {
    features {} # This empty block is required
}