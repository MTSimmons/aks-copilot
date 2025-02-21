
resource "azuread_group" "admin_group" {
    display_name     = "${var.cluster_name}-admin-group"
    description = "Admins for the ${var.cluster_name} AKS cluster"
    security_enabled = true
}

data "azuread_user" "by_email" {
    for_each              = toset(var.aks_admin_user_email_list)
    user_principal_name   = each.value
}

resource "azuread_group_member" "email_members" {
    for_each        = data.azuread_user.by_email
    group_object_id = azuread_group.admin_group.id
    member_object_id = each.value.object_id
}