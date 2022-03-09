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

Provider versions
------------------
registry.terraform.io/hashicorp/azurerm v2.98.0

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
  source                  = "git::https://gitlab.com/tanya.sapra/aishwarya-training/-/tree/ACR.git

  Registry_Name = "_"
  RG_name       = "_"
  ACR_location  = "_"
  sku           = "_"
  admin                     = "_"
  quarantine_policy_enabled = "_"
  Publicaccess              = "_"
  trust_policy              = "_"
  retention                 = {
    "enabled"    = "_"
    "days"       = "_"
  }
  zone_redundancy_enabled   = "_"
  tag_map = {
    "env"        = "_"
    "created by" = "_"
  }
  georeplications    = ["_", "_"]
  identity           = "_"
  encryption         = "_"
  key_vault_key_id   = "_"
  identity_client_id = "_"
  lock_level_value   = "_"
}

```
**NOTE: You can also refer the variable.tf file under example directory to get the idea on variables define in module.**

Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additional tags can be assigned by tags variables as defined above.
* Testing this.

NOTE
----
This module is used for both SystemAssigned and UserAssigned Identity. If you want to know key_vault_key_id and identity_client_id for encryption purpose then use data.tf Terraform file.

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
| RG_name | RG of the subnet | `string` |  | yes |
| Registry_Name | Name of the Azure Container Registry | `string` |  | yes |
| ACR_location | Location of Azure Container Registry | `string` | Basic  | yes |
| sku | Map to define the sku of the Azure Container Registry: 'Basic', 'Standard', or 'Premium' | `string` |  | yes |
| admin | To Enable Admin | `bool` |  | no |
| quarantine_policy_enabled | To Enable quarantine policy (Only Available for Premium) | `bool` |  | no |
| Publicaccess | To enable Public Access in Connectivity Configurations | `bool` |  | no |
| retention | The number of days to retain an untagged manifest after which it gets purged. (Only Available for Premium) | `list(map)` |  | no |
| trust_policy | To enable Trust policy (Only Available for Premium) | `bool` | `` | no |
| georeplications | A list of Azure locations where the container registry should be geo-replicated.Location is to be added here (Only Available for Premium) | `list(any)` |  | no |
| zone_redundancy_enabled | To enable Zone Redundancy (Only Available for Premium) | `bool` |  | no |
| identity | Please mention the type of identity - 'UserAssigned' or 'SystemAssigned' | `string` |  | no |
| encryption | Please mention True (to enable) or False (to disable) Encryption | `bool` |  | no |
| key_vault_key_id | Please mention the Key Vault Key ID for Encryption | `string` |  | no |
| identity_client_id | Please mention the Managed Identity Client ID for Encryption | `string` |  | no |
| lock_level_value | Please mention the level of lock that is to be applied in Azure Container Registry | `string` |  | no |
| tag_map | Please mention the tags here | `map(string)` |  | no |



Output
------
| Name | Description |
|------|-------------|
| ACR_id | ID of the Azure Container Registry |
| ACR_Login | URL that can be used to log into the Azure Container Registry |
| container_registry_admin_username | (Only if Admin is enabled) The Username associated with the Container Registry Admin account |
| container_registry_admin_password | (Only if Admin is enabled) The Username associated with the Container Registry Admin account |
| container_registry_identity_tenant_id | The Tenant ID for the Service Principal associated with the Managed Service Identity of this Container Registry |

## Related Projects

Check out these related projects.

* [Resource Group](https://gitlab.com/ot-azure/terraform/rg)

### Contributor

|  [![S Aishwarya][Aishwarya_avatar]][Aishwarya_homepage]<br/>[S Aishwarya][Aishwarya_homepage] |
|---|

  [Aishwarya_homepage]: https://gitlab.com/aishwaryasopstree
  [Aishwarya_avatar]: https://gitlab.com/uploads/-/system/user/avatar/10902824/avatar.png?width=400

