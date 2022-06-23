######################## Azure Container Registry ##############################

resource "azurerm_container_registry" "ContainerRegistry" {
  name                          = var.container_registry_name
  resource_group_name           = var.resource_group_name
  location                      = var.acr_location
  sku                           = var.sku
  admin_enabled                 = var.admin_enabled
  public_network_access_enabled = var.public_network_access
  zone_redundancy_enabled       = var.zone_redundancy_enabled
  data_endpoint_enabled         = var.sku == "Premium" ? var.data_endpoint_enabled : false
  anonymous_pull_enabled        = var.sku == "Premium" || var.sku == "Standard" ? var.anonymous_pull_enabled : false
  quarantine_policy_enabled     = var.sku == "Premium" ? var.quarantine_policy_enabled : false
  network_rule_bypass_option    = var.network_rule_bypass_option
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
    for_each = var.trust_policy != null && var.sku == "Premium" && var.encryption == "false" ? ["enabled"] : []
    content {
      enabled = var.trust_policy
    }
  }

  identity {
    type         = var.identity
    identity_ids = var.identity == "UserAssigned" ? [var.identity_id] : []
  }

  dynamic "encryption" {
    for_each = var.encryption != false && var.sku == "Premium" ? [var.encryption] : []
    content {
      enabled            = var.encryption
      key_vault_key_id   = var.key_vault_key_id
      identity_client_id = var.identity_client_id
    }
  }
}

############################## Private Endpoint ###############################

resource "azurerm_private_endpoint" "acr_private_endpoint" {
  count               = var.enable_private_endpoint && var.sku == "Premium" ? 1 : 0
  name                = var.container_registry_name
  location            = var.acr_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tag_map
  private_dns_zone_group {
    name                 = "container-registry-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.dnszoneacr.0.id]
  }

  private_service_connection {
    name                           = "containerregistryprivatelink"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_container_registry.ContainerRegistry.id
    subresource_names              = ["registry"]
  }
}

resource "azurerm_private_dns_zone" "dnszoneacr" {
  count               = var.existing_private_dns_zone == null && var.enable_private_endpoint && var.sku == "Premium" ? 1 : 0
  name                = "privatelink.azurecr.io"
  resource_group_name = var.resource_group_name
  tags                = var.tag_map
}

resource "azurerm_private_dns_zone_virtual_network_link" "vent-link1" {
  count                 = var.existing_private_dns_zone == null && var.enable_private_endpoint && var.sku == "Premium" ? 1 : 0
  name                  = "vnet-private-zone-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dnszoneacr.0.name
  virtual_network_id    = var.virtual_network_id
  registration_enabled  = true
  tags                  = var.tag_map
}

############################## Resource Lock ##################################

resource "azurerm_management_lock" "primary_lock" {
  count      = var.lock_level_value == "" ? 0 : 1
  name       = "${var.container_registry_name}-lock"
  scope      = azurerm_container_registry.ContainerRegistry.id
  lock_level = var.lock_level_value
  notes      = "Azure Container Registry '${var.container_registry_name}' is locked with '${var.container_registry_name}' level"
}

