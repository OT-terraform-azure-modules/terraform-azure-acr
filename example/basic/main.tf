data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

module "acr" {
    source = "../"
    resource_group_name = module.res_group.name
    
}