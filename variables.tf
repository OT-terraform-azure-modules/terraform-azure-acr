variable "resource_group" {}

variable "acr_location" {
  default = "eastus"
}

variable "acr_name" {}

variable "acr_sku" {
  default = "Basic"
}

variable "tags" {
  type = map(string)
  default = {
    env : "staging"
  }
}


