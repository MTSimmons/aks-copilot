
# Resource group
resource "azurerm_resource_group" "rg" {
    name     = var.resource_group_name
    location = var.resource_group_location

    tags = {
        environment = "demo"
        managed_by  = "terraform"
    }
}