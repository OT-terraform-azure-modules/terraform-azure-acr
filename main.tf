resource "random_string" "random" {
  length = 4
  special = false
}

resource "azurerm_container_registry" "TerraformContr_Reg" {
  name                = join("-",[var.acr_name, random_string.random.result])
  resource_group_name = var.resource_group
  location            = var.acr_location
  sku                 = var.acr_sku
  tags                = var.tags
}

