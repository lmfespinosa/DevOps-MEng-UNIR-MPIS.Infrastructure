# https://www.terraform.io/docs/providers/azurerm/r/sql_database.html

# Variables
# Any new database should be set on terraform-devops-library.tf 

variable "databases" {
    type                              = list(string)
    default                           = [ "device", "user"]
}

# Resources

resource "azurerm_sql_database" "database" {
  count                               = length(var.databases)
  name                                = "db-${var.databases[count.index]}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  server_name                         = azurerm_sql_server.sqlserver.name
  tags                                = merge(var.azure_common_tags, {"service" = "database" })
  collation                           = "Latin1_General_CI_AI"
  elastic_pool_name                   = azurerm_sql_elasticpool.elasticpool.name

  depends_on                          = [azurerm_sql_server.sqlserver]
}

resource "azurerm_sql_database" "testdatabase" {
  count                               = var.environment == "dev" ? length(var.databases) : 0 # conditional creation
  name                                = "db-test-${var.databases[count.index]}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  server_name                         = azurerm_sql_server.sqlserver.name
  tags                                = merge(var.azure_common_tags, {"service" = "database" })
  collation                           = "Latin1_General_CI_AI"
  elastic_pool_name                   = azurerm_sql_elasticpool.elasticpool.name

  depends_on                          = [azurerm_sql_server.sqlserver]
}