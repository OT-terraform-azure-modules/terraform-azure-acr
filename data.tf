provider "azurerm" {
  features {}
}

data "azurerm_user_assigned_identity" "userassignedid" {
  name                = "" #Enter ManagedID Name
  resource_group_name = "" #Enter Resource Group Name
}

data "azurerm_key_vault" "key_vault" {
  name                = "" #Enter Key Vault Name
  resource_group_name = "" #Enter Resource Group Name
}

data "azurerm_key_vault_key" "Keyvalue" {
  name         = "" #Enter Key Name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

output "UserAssignedManagedID" {
  value       = data.azurerm_user_assigned_identity.userassignedid.client_id
  description = "User Assigned Managed Identity - Client ID"
}

output "KeyVaultID" {
  value       = data.azurerm_key_vault.key_vault.id
  description = "Key Vault ID"
}
