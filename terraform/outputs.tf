output "resource_group_name" {
    description = "The name of the resource group"
    value       = azurerm_resource_group.rg.name
}

output "aks_cluster_name" {
    description = "The name of the AKS cluster"
    value       = module.aks.name
}

output "aks_cluster_id" {
    description = "The ID of the AKS cluster"
    value       = module.aks.id
}

output "kube_config" {
    description = "The kubeconfig for the AKS cluster"
    value       = module.aks.kube_config
    sensitive   = true
}

output "cluster_fqdn" {
    description = "The FQDN of the AKS cluster"
    value       = module.aks.fqdn
}

output "node_resource_group" {
    description = "The auto-generated resource group which contains the resources for this AKS cluster"
    value       = module.aks.node_resource_group
}