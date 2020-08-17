#
# Custom roles assignment
#

# IAM for subscriptions
module custom_role_assignment_subscriptions {
  source   = "/tf/caf/modules/role_assignment"
  for_each = lookup(var.role_mapping.custom_role_mapping, "subscription_keys", {})

  mode                 = "custom"
  scope                = each.key == "logged_in_subscription" ? data.azurerm_subscription.primary.id : format("/subscription/%s", var.subscriptions[each.key].subscription_id)
  role_mappings        = each.value
  azuread_apps         = module.azuread_applications
  azuread_groups       = module.azuread_groups
  managed_identities   = azurerm_user_assigned_identity.msi
  custom_roles         = module.custom_roles
}

# # IAM for resource groups
# module role_assignment_resource_groups {
#   source   = "/tf/caf/modules/role_assignment"
#   for_each = lookup(var.role_mapping.built_in_role_mapping, "resource_group_keys", {})

#   scope                = azurerm_resource_group.rg[each.key].id
#   role_definition_name = each.key
#   role_mappings        = each.value
#   azuread_apps         = module.azuread_applications
#   azuread_groups       = module.azuread_groups
#   managed_identities   = azurerm_user_assigned_identity.msi
# }

# # IAM for storage accounts
# module role_assignment_storage_accounts {
#   source   = "/tf/caf/modules/role_assignment"
#   for_each = lookup(var.role_mapping.built_in_role_mapping, "storage_account_keys", {})

#   scope                = module.storage_accounts[each.key].id
#   role_definition_name = each.key
#   role_mappings        = each.value
#   azuread_apps         = module.azuread_applications
#   azuread_groups       = module.azuread_groups
#   managed_identities   = azurerm_user_assigned_identity.msi
# }
