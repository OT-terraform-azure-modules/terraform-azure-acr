provider "azurerm" {
  features {}
}

data "azurerm_virtual_network" "virtual_network" {
  name                = "example-vnet"          #Enter Virtual Network Name
  resource_group_name = "example-resourcegroup" #Enter Resource Group Name
}

data "azurerm_subnet" "subnet_acr" {
  name                 = "example-subnet-name"   #Enter Subnet Name present in Virtual Network
  resource_group_name  = "example-resourcegroup"        #Enter Resource Group Name
  virtual_network_name = "example-vnet" #Enter Virtual Network Name
}

data "azurerm_user_assigned_identity" "userassignedid" {
  name                = "userassignedid-name"   #Enter ManagedID Name
  resource_group_name = "example-resourcegroup" #Enter Resource Group Name
}

data "azurerm_key_vault" "key_vault" {
  name                = "example-keyvault"      #Enter Key Vault Name
  resource_group_name = "example-resourcegroup" #Enter Resource Group Name
}

data "azurerm_key_vault_key" "keyvalue" {
  name         = "key-name" #Enter Key Name
  key_vault_id = data.azurerm_key_vault.key_vault.id
}

module "acr" {
  source                     = "../../"
  container_registry_name    = "examplexmplregistry"
  resource_group_name        = "example-resourcegroup"
  acr_location               = "eastus"
  sku                        = "Premium"
  admin_enabled              = true
  public_network_access      = true
  trust_policy               = true
  zone_redundancy_enabled    = true
  georeplications            = ["centralus", "centralindia"]
  retention                  = null
  identity                   = "UserAssigned"
  identity_id                = data.azurerm_user_assigned_identity.userassignedid.id
  encryption                 = true
  key_vault_key_id           = data.azurerm_key_vault_key.keyvalue.id
  identity_client_id         = data.azurerm_user_assigned_identity.userassignedid.client_id
  data_endpoint_enabled      = true
  anonymous_pull_enabled     = true
  quarantine_policy_enabled  = false
  network_rule_bypass_option = "AzureServices"
  enable_private_endpoint    = true
  existing_private_dns_zone  = null
  virtual_network_id         = data.azurerm_virtual_network.virtual_network.id
  subnet_id                  = data.azurerm_subnet.subnet_acr.id
  lock_level_value           = ""
  tag_map = {
    "env"        = "environment-name"
    "created by" = "example"
  }
}
