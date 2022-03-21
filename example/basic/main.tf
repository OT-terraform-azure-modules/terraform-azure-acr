provider "azurerm" {
  features {}
}
module "res_group" {
  source                  = "OT-terraform-azure-modules/resource-group/azure"
  resource_group_name     = "example-rg"
  resource_group_location = "east us"
  tag_map = {
    Name = "AzureResourceGroup"
  }
}

module "acr" {
  source                     = "../"
  container_registry_name    = "examplexmpregistry"
  resource_group_name        = module.res_group.resource_group_name
  acr_location               = "east us"
  sku                        = "Basic"
  admin_enabled              = false
  public_network_access      = true
  trust_policy               = false
  zone_redundancy_enabled    = false
  georeplications            = []
  retention                  = null
  identity                   = "SystemAssigned"
  identity_id                = null
  encryption                 = null
  key_vault_key_id           = null
  identity_client_id         = null
  network_rule_bypass_option = "AzureServices"
  lock_level_value           = ""
  tag_map = {
    "env"        = "environment-name"
    "created by" = "example"
  }
}
