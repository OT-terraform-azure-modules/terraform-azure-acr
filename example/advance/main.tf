provider "azurerm" {
  features {}
}

data "azurerm_user_assigned_identity" "userassignedid" {
  name                = "userassignedid-name" #Enter ManagedID Name
  resource_group_name = "example-resourcegroup" #Enter Resource Group Name
}

data "azurerm_key_vault" "key_vault" {
  name                = "example-keyvault" #Enter Key Vault Name
  resource_group_name = "example-resourcegroup" #Enter Resource Group Name
}

data "azurerm_key_vault_key" "keyvalue" {
  name         = "key-name" #Enter Key Name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "acr" {
  source                  = "../../"
  container_registry_name = "indusindxmpregistry"
  resource_group_name     = "example-resourcegroup"
  acr_location            = "eastus"
  sku                     = "Premium"
  admin_enabled           = true
  public_network_access   = true
  trust_policy            = true
  zone_redundancy_enabled = true
  georeplications         = ["centralus","centralindia"]
  retention               = null
  identity                = "UserAssigned"
  identity_id             = data.azurerm_user_assigned_identity.userassignedid.id
  encryption              = true
  key_vault_key_id        = data.azurerm_key_vault_key.keyvalue.id
  identity_client_id      = data.azurerm_user_assigned_identity.userassignedid.client_id
  lock_level_value        = ""
}
