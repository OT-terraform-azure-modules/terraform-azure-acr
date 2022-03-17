admin_enabled         = "true"
public_network_access = "true"
trust_policy          = "true"
tag_map = {
  "env"        = "Production"
  "created by" = "Aishwarya"
}
georeplications         = ["East US", "West US"]
sku                     = "Premium"
identity_id             = "/subscriptions/444e2350-bf5b-4829-b8f8-5b3e1e2eabe1/resourceGroups/aishwarya/providers/Microsoft.ManagedIdentity/userAssignedIdentities/aishwarya"
resource_group_name     = "aishwarya"
acr_location            = "eastus"
container_registry_name = "aishwaryaacrops"
encryption              = true
key_vault_key_id        = "https://aishkey1.vault.azure.net/keys/AishwaryaKey/e9d80ef294504581a488214ee4a9c0f8"
identity_client_id      = "fc23506c-72d6-49fd-91ce-83355ab1651d"