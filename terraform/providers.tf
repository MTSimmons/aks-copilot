terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = "~> 4.0.0"  # Latest stable version as of now
        }
        azuread = {
            source  = "hashicorp/azuread"
            version = "~> 3.0.0"
        }
    }
}

provider "azurerm" {
    features {} # This empty block is required
    tenant_id = var.arm_tenant_id
    subscription_id = var.arm_subscription_id
    client_id = var.arm_client_id
    client_secret = var.arm_client_secret
}

provider "azuread" {
    tenant_id = var.arm_tenant_id
    client_id = var.arm_client_id
    client_secret = var.arm_client_secret
}