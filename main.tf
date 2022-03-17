provider "azurerm" {
  features {}
}

resource "azurerm_container_registry" "ContainerRegistry" {
  name                          = var.container_registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.acr_location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  tags                          = var.tag_map

  dynamic "georeplications" {
    for_each = var.georeplications != null && var.sku == "Premium" ? var.georeplications : []
    content {
      location                = try(georeplications.value.location, georeplications.value)
      zone_redundancy_enabled = try(georeplications.value.zone_redundancy_enabled, var.zone_redundancy_enabled)
      tags                    = try(georeplications.value.tags, var.tag_map)
    }
  }

  dynamic "retention_policy" {
    for_each = var.retention != null && var.sku == "Premium" ? ["enabled"] : []
    content {
      enabled = lookup(retention.value, "enabled", false)
      days    = lookup(retention.value, "days", 0)
    }
  }

  dynamic "trust_policy" {
    for_each = var.trust_policy != null && var.sku == "Premium" && var.encryption != "true" ? ["enabled"] : []
    content {
      enabled = var.trust_policy
    }
  }
  identity {
    type         = var.identity
    identity_ids = var.identity == "UserAssigned" ? [var.identity_id] : []
  }
  dynamic "encryption" {
    for_each = var.encryption != null && var.sku == "Premium" ? [var.encryption] : []
    content {
      enabled            = var.encryption
      key_vault_key_id   = var.key_vault_key_id
      identity_client_id = var.identity_client_id
    }
  }
}
resource "azurerm_management_lock" "primary_lock" {
  count      = var.lock_level_value == "" ? 0 : 1
  name       = "${var.container_registry_name}-lock"
  scope      = azurerm_container_registry.ContainerRegistry.id
  lock_level = var.lock_level_value
  notes      = "Azure Container Registry '${var.container_registry_name}' is locked with '${var.container_registry_name}' level"
}