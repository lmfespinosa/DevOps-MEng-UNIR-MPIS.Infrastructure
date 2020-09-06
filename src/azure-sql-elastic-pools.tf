# https://www.terraform.io/docs/providers/azurerm/r/sql_elasticpool.html

# Variables

# Resources

resource "azurerm_sql_elasticpool" "elasticpool" {
    name                                = "elastic_pool_${var.environment}"
    resource_group_name                 = azurerm_resource_group.resourcegroup.name
    location                            = var.azure_location
    server_name                         = azurerm_sql_server.sqlserver.name
    edition                             = "Basic"
    dtu                                 = 50
    db_dtu_min                          = 0
    db_dtu_max                          = 5
    pool_size                           = 5000
    tags                                = merge(var.azure_common_tags, {"service" = "elastic-pool" })
}

