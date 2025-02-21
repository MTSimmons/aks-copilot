# Variables for Azure provider
variable "arm_client_id" {
    type        = string
    description = "The Client ID which should be used."
}

variable "arm_client_secret" {
    type        = string
    description = "The Client Secret which should be used."
    sensitive   = true
}

variable "arm_subscription_id" {
    type        = string
    description = "The Subscription ID which should be used."
}

variable "arm_tenant_id" {
    type        = string
    description = "The Tenant ID which should be used."
}



# Variables for resource group
variable "resource_group_name" {
    description = "Name of the resource group"
    type        = string
}

variable "resource_group_location" {
    description = "Azure region where the resource group will be created"
    type        = string
    default     = "eastus"
}


# Variables for AKS cluster
variable "cluster_name" {
    description = "Name of the AKS cluster"
    type        = string
}

variable "cluster_location" {
    description = "Azure region where the AKS cluster will be created"
    type        = string
    default     = "eastus"
}

variable "default_node_pool_vm_size" {
    description = "VM size for the default node pool"
    type        = string
    default     = "Standard_D2_v2"
}

variable "default_node_count" {
    description = "Number of nodes in the default node pool"
    type        = number
    default     = 1
}