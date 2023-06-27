variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
  nullable    = false
}
variable "container_registry_name" {
  type        = string
  description = "Azure Container Registry Name"
  validation {
    condition     = length(var.container_registry_name) > 3 && length(var.container_registry_name) < 24
    error_message = "Container Registry name must be between 3 to 24 letters and should not contain any special characters."
  }
  nullable = false
}
variable "acr_location" {
  type        = string
  description = "Location of Azure Container Registry"
  nullable    = false
}
variable "sku" {
  type        = string
  description = "which SKU do you want (options: Basic,Standard,Premium) "
  default     = "Basic"
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "Argument 'sku' must one of 'Basic', 'Standard', or 'Premium'."
  }
  nullable = false
}
variable "admin_enabled" {
  type        = bool
  description = "Admin Enabled  : True or False "
  validation {
    condition     = contains([true, false], var.admin_enabled)
    error_message = "Argument 'admin' must one of 'True' or 'False'."
  }
  default = false
}
variable "public_network_access" {
  type        = bool
  description = "Public network access: true or false"
  validation {
    condition     = contains([true, false], var.public_network_access)
    error_message = "Argument 'Publicaccess' must one of 'True' or 'False'."
  }
  default = true
}

variable "anonymous_pull_enabled" {
  type        = bool
  description = "Anonymous Pull access: true or false"
  validation {
    condition     = contains([true, false], var.anonymous_pull_enabled)
    error_message = "Argument 'anonymous pull access' must one of 'True' or 'False'."
  }
  default = false
}

variable "data_endpoint_enabled" {
  type        = bool
  description = "Want to enable Data Endpoint ? : true or false"
  validation {
    condition     = contains([true, false], var.data_endpoint_enabled)
    error_message = "Argument 'Data Endpoint Enabled' must one of 'True' or 'False'."
  }
  default = false
}

variable "quarantine_policy_enabled" {
  type        = bool
  description = "Quarantine policy access enabled : true or false"
  validation {
    condition     = contains([true, false], var.quarantine_policy_enabled)
    error_message = "Argument 'Quarantine policy access' must one of 'True' or 'False'."
  }
  default = false
}

variable "retention" {
  type        = map(object({ enabled = bool, days = number }))
  description = "The number of days to retain an untagged manifest after which it gets purged."
  default     = null
}
variable "trust_policy" {
  type        = bool
  description = "Trust Policy : True(Enable) or False(Disable)"
  validation {
    condition     = contains([true, false], var.trust_policy)
    error_message = "Argument 'Trust Policy' must one of 'True' or 'False'."
  }
  default = false
}
variable "georeplications" {
  type        = list(string)
  description = "A list of Azure locations where the container registry should be geo-replicated.Location is to be added here"
  default     = []
}
variable "zone_redundancy_enabled" {
  type        = bool
  description = "Zone Redundancy Enabled: True(Enable) or False (Disable)"
  validation {
    condition     = contains([true, false], var.zone_redundancy_enabled)
    error_message = "Argument 'Zone Redundancy Enabled' must one of 'True' or 'False'."
  }
  default = false
}
variable "tag_map" {
  type        = map(string)
  description = "Map of Tags those we want to Add"
  default     = {}
}
variable "identity" {
  type        = string
  description = "Enter Identity level - Possible values are 'UserAssigned' and 'SystemAssigned'"
  validation {
    condition     = contains(["UserAssigned", "SystemAssigned"], var.identity)
    error_message = "Argument 'identity' must one of 'SystemAssigned' or 'UserAssigned' or both."
  }
  default = "SystemAssigned"
}
variable "identity_id" {
  type        = string
  description = "Enter Identity ID of User assigned managed identity."
  default     = null
}
variable "encryption" {
  description = "Encrypt registry using a key"
  type        = bool
  default     = null
}
variable "key_vault_key_id" {
  type        = string
  description = "Enter the existing Key Vault Key ID"
  default     = null
}
variable "identity_client_id" {
  type        = string
  description = "Enter the existing Managed Identity Client ID"
  default     = null
}
variable "lock_level_value" {
  type        = string
  description = "(Required) Specifies the Level to be used for this Lock. Possible values are `Empty (no lock)`, `CanNotDelete` and `ReadOnly`. Changing this forces a new resource to be created"
}

variable "enable_private_endpoint" {
  type        = bool
  description = "Manages a Private Endpoint to Azure Container Registry"
  default     = false
  validation {
    condition     = contains([true, false], var.enable_private_endpoint)
    error_message = "Argument 'Zone Redundancy Enabled' must one of 'True' or 'False'."
  }
}

variable "existing_private_dns_zone" {
  type        = any
  description = "Name of the existing private DNS zone"
  default     = null
}

variable "virtual_network_id" {
  type        = string
  description = "The ID of the virtual network (virtual network Region and ACR location must be same)"
  default     = ""
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet (Subnet Region and ACR location must be same)"
  default     = ""
}

variable "network_rule_bypass_option" {
  type        = string
  description = "Change network rule bypass option : Possible Values AzureServices or None"
  default     = "AzureServices"
}
