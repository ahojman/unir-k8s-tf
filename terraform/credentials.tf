# Andres Hojman

provider "azurerm" {
  features {}
  subscription_id = var.azure_sub_id
  client_id       = var.azure_spn_id
  client_secret   = var.azure_spn_secret
  tenant_id       = var.azure_tenant
}