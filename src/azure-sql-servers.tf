# https://www.terraform.io/docs/providers/azurerm/r/sql_server.html

# Variables

variable "azure_sql_server_username" {
    type                              = string
    default                           = "kerberos"
}

# Resources

resource "azurerm_sql_server" "sqlserver" {
  name                                = "server-${var.azure_simplified_resource_group}-${var.environment}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  version                             = "12.0"
  administrator_login                 = var.azure_sql_server_username
  administrator_login_password        = random_password.password.result 
  tags                                = merge(var.azure_common_tags, {"service" = "sql-server" })
}
