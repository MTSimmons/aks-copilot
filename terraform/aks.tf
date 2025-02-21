module "aks" {
    source  = "Azure/avm-res-containerservice-managedcluster/azurerm"
    version = "0.1.4"

    # Required
    name                = var.cluster_name
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.cluster_location
    default_node_pool = {
        name                = "default"
        vm_size            = var.default_node_pool_vm_size
        node_count         = var.default_node_count
    }

    # Optional

    # This is the default settings.  Just listed here for fun!
    network_profile = {
        "network_plugin": "azure",
        "network_plugin_mode": "overlay",
        "network_policy": "azure"
    }

    managed_identities = {
        system_assigned = true
    }

    azure_active_directory_role_based_access_control = {
      admin_group_object_ids = [azuread_group.admin_group.object_id]
    }

    # network_profile = {
    #     network_plugin    = "azure"
    #     load_balancer_sku = "standard"
    # }

    # tags = var.tags
}

# The variables section can remain the same as it is compatible with the new module
