# https://www.terraform.io/docs/providers/azurerm/r/storage_account.html

# Variables

# Resources

resource "azurerm_storage_account" "functionsstorage" {
  name                                = "mpisstgfunc${var.environment}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  account_tier                        = "Standard"
  account_replication_type            = "LRS"
  tags                                = merge(var.azure_common_tags, {"service" = "storage" })
}

