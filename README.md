Azure Container Registry Terraform Module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage]

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates Azure Container Registry.

Terraform versions
------------------
Terraform v1.1.7

Usage
------

```hcl

module "res_group" {
  source                  = "git::https://github.com/OT-terraform-azure-modules/azure_resource_group.git"
  resource_group_name     = "_"
  resource_group_location = "_"
  lock_level_value        = "_"
  tag_map = {
    Name = "AzureResourceGroup"
  }
}

module "ACR" {
  source                  = "git::https://github.com/OT-terraform-azure-modules/ACR.git
  Registry_Name = "_"
  RG_name       = "_"
  ACR_location  = "_"
  sku           = "_"
  admin                     = "_"
  quarantine_policy_enabled = "_"
  Publicaccess              = "_"
  trust_policy              = "_"
  zone_redundancy_enabled   = "_"
  georeplications    = ["_", "_"]
  identity           = "_"
  encryption         = "_"
  key_vault_key_id   = "_"
  identity_client_id = "_"
  lock_level_value   = "_"
}

```

Resources
------
| Name | Type |
|------|------|
| [azurerm_container_registry.ContainerRegistry](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry) | resource |
| [azurerm_management_lock.primary_lock](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/management_lock) | resource |


Inputs
------
| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| resource_group_name | Enter the Resource group name | `string` |  | yes |
| container_registry_name | Name of the Azure Container Registry | `string` |  | yes |
| acr_location | Location of Azure Container Registry | `string` |   | yes |
| sku | Map to define the sku of the Azure Container Registry: 'Basic', 'Standard', or 'Premium' | `string` | Basic  | no |
| admin_enabled | To Enable Admin | `bool` | false | no |
| public_network_access | To enable Public Access in Connectivity Configurations | `bool` | true | no |
| retention | The number of days to retain an untagged manifest after which it gets purged. (Only Available for Premium) | `map(object)` | null | no |
| trust_policy | To enable Trust policy (Only Available for Premium) | `bool` | false | no |
| georeplications | A list of Azure locations where the container registry should be geo-replicated. Location is to be added here (Only Available for Premium) | `list(string)` |  | no |
| zone_redundancy_enabled | To enable Zone Redundancy (Only Available for Premium) | `bool` | false | no |
| identity | Please mention the type of identity - 'UserAssigned' or 'SystemAssigned' | `string` | SystemAssigned | no |
| encryption | Please mention True (to enable) or False (to disable) Encryption | `bool` | null | no |
| key_vault_key_id | Please mention the Key Vault Key ID for Encryption | `string` | null | no |
| identity_client_id | Please mention the Managed Identity Client ID for Encryption | `string` | null | no |
| lock_level_value | Please mention the level of lock that is to be applied in Azure Container Registry | `string` | null | no |
| identity_id | Please mention the Managed Identity ID | `string` | null | no |
| tag_map | Please mention the tags here | `map(string)` |  | no |

NOTE
----
The Geo-replication regions must be different from ACR location (this feature is available for Premium sku).

Output
------
| Name | Description |
|------|-------------|
| acr_id | ID of the Azure Container Registry |
| acr_login | URL that can be used to log into the Azure Container Registry |
| container_registry_admin_username | (Only if Admin is enabled) The Username associated with the Container Registry Admin account |
| container_registry_admin_password | (Only if Admin is enabled) The Username associated with the Container Registry Admin account |
| container_registry_identity_tenant_id | The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry |

## Related Projects

Check out these related projects.

* [Resource Group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group)

### Contributor

|  [![S Aishwarya][Aishwarya_avatar]][Aishwarya_homepage]<br/>[S Aishwarya][Aishwarya_homepage] |
|---|

  [Aishwarya_homepage]: https://gitlab.com/aishwaryasopstree
  [Aishwarya_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10902824/avatar.png?width=400
