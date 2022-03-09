variable "Registry_Name" {
  type        = string
  description = "Azure Container Registry Name"
  nullable    = false
}

variable "RG_name" {
  type        = string
  description = "Resource Group Name"
  nullable    = false
}

variable "ACR_location" {
  type        = string
  description = "Location of Azure Container Registry"
  nullable    = false
}

variable "sku" {
  type        = string
  default     = "Basic"
  description = "which SKU do you want (options: Basic,Standard,Premium) "
  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "Argument 'sku' must one of 'Basic', 'Standard', or 'Premium'."
  }
  nullable = false
}


variable "admin" {
  type        = bool
  description = "Admin Enabled  : True or False "
  validation {
    condition     = contains(["true", "false"], var.admin)
    error_message = "Argument 'admin' must one of 'True' or 'False'."
  }
  default = null
}

variable "quarantine_policy_enabled" {
  type        = bool
  description = "Quarantine Policy Enabled  : True or False "
  validation {
    condition     = contains(["true", "false"], var.quarantine_policy_enabled)
    error_message = "Argument 'admin' must one of 'True' or 'False'."
  }
  default = null
}

variable "Publicaccess" {
  type        = bool
  description = "Public network access: true or false"
  validation {
    condition     = contains(["true", "false"], var.Publicaccess)
    error_message = "Argument 'Publicaccess' must one of 'True' or 'False'."
  }
  default = null
}

variable "retention" {
  type        = list(object({ enabled = bool, days = number }))
  description = "The number of days to retain an untagged manifest after which it gets purged."
  default     = null
}

variable "trust_policy" {
  type        = bool
  description = "Trust Policy : True(Enable) or False(Disable)"
  validation {
    condition     = contains(["true", "false"], var.trust_policy)
    error_message = "Argument 'Trust Policy' must one of 'True' or 'False'."
  }
  default = null
}

variable "georeplications" {
  description = "A list of Azure locations where the container registry should be geo-replicated.Location is to be added here"
  type        = list(any)
  default     = []
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Zone Redundancy Enabled: True(Enable) or False (Disable)"
  validation {
    condition     = contains(["true", "false"], var.zone_redundancy_enabled)
    error_message = "Argument 'Zone Redundancy Enabled' must one of 'True' or 'False'."
  }
  default = null
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
    error_message = "Argument 'identity' must one of 'SystemAssigned' or 'UserAssigned'."
  }
  default = null
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
  default     = "CanNotDelete"
  description = "(Required) Specifies the Level to be used for this Lock. Possible values are `Empty (no lock)`, `CanNotDelete` and `ReadOnly`. Changing this forces a new resource to be created"
}
