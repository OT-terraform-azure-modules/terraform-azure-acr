
output "acr_id" {
  value       = azurerm_container_registry.ContainerRegistry.id
  description = "ID of the Azure Container Registry"
}

output "acr_login" {
  value       = azurerm_container_registry.ContainerRegistry.login_server
  description = "URL that can be used to log into the Azure Container Registry"
}

output "container_registry_admin_username" {
  description = "(Only if Admin is enabled) The Username associated with the Container Registry Admin account"
  value       = var.admin_enabled == true ? azurerm_container_registry.ContainerRegistry.admin_username : null
}

output "container_registry_admin_password" {
  description = "(Only if Admin is enabled) The Username associated with the Container Registry Admin account"
  value       = var.admin_enabled == true ? azurerm_container_registry.ContainerRegistry.admin_password : null
  sensitive   = true
}

output "container_registry_identity_tenant_id" {
  description = "The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry"
  value       = flatten(azurerm_container_registry.ContainerRegistry.identity.*.tenant_id)
}
