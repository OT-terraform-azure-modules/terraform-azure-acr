Azure ACR (Azure Container Registry) Terraform module
=====================================

[![Opstree Solutions][opstree_avatar]][opstree_homepage]

[Opstree Solutions][opstree_homepage] 

  [opstree_homepage]: https://opstree.github.io/
  [opstree_avatar]: https://img.cloudposse.com/150x150/https://github.com/opstree.png

Terraform module which creates ACR on Azure.

These types of resources are supported:

* [ACR](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/container_registry)

Terraform versions
------------------

Terraform 0.13.

Usage
------

```hcl
module "ACR" {
  source         = "./modules/ACR"
  acr_name       = "TerraformACR"
  acr_location   = "eastus"
  resource_group = "acr_resource_group"
  acr_sku        = "Basic"
  tags = {
    env : "staging"
  }
}

```


Tags
----
* Tags are assigned to resources with name variable as prefix.
* Additial tags can be assigned by tags variables as defined above.

Inputs
------
| Name           | Description                           | Type     | Default                | Required  |
|----------------|---------------------------------------|----------|------------------------|:---------:|
| acr_name       | Name of the ACR                       | `string` | `"TerraformACR"`       | yes       |
| acr_location   | Location in which ACR will be created | `string` | `"eastus"`             | no        |
| resource_group | Resource Group of ACR                 | `string` | `"acr_resource_group"` | yes       |
| acr_sku        | SKU of ACR                            | `string` | `"Basic"`              | no        |
| tags           | Tags assigned to ACR                  | `string` | `"staging"`            | no        |

Output
------
| Name            |                    Description                              |
|-----------------|-------------------------------------------------------------|
|acr_login_server |This variable will give details about the login server of ACR|


