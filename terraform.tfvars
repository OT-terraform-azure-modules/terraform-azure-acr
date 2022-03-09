####Mandatory Variables####
Registry_Name = ""
RG_name       = ""
ACR_location  = ""
sku           = ""
####Optional Variables####
admin                     = "true"
quarantine_policy_enabled = "true"
Publicaccess              = "true"
trust_policy              = "true"
retention                 = {
  "enabled"    = ""
  "days"       = ""
}
zone_redundancy_enabled   = ""
tag_map = {
  "env"        = "Production"
  "created by" = ""
}
georeplications    = ["East US", "West US"]
identity           = "SystemAssigned"
encryption         = "true"
key_vault_key_id   = ""
identity_client_id = ""
lock_level_value   = "CanNotDelete"
