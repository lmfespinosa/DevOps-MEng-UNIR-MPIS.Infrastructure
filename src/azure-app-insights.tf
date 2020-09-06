# https://www.terraform.io/docs/providers/azurerm/r/application_insights.html

# Variables

# Resources

resource "azurerm_application_insights" "functioninsights" {
  count                             = length(var.functionapps)
  name                              = "insights-${var.functionapps[count.index]}-${var.environment}"
  resource_group_name               = azurerm_resource_group.resourcegroup.name
  location                          = var.azure_location
  application_type                  = "web"
  depends_on                        = [azurerm_resource_group.resourcegroup]
  tags                              = merge(var.azure_common_tags, {"service" = "app-insights" })
}

resource "azurerm_application_insights" "functioninsights_test" {
  count                             = length(var.functionapps)
  name                              = "insights-${var.functionapps[count.index]}-${var.environment}-test"
  resource_group_name               = azurerm_resource_group.resourcegroup.name
  location                          = var.azure_location
  application_type                  = "web"
  depends_on                        = [azurerm_resource_group.resourcegroup]
  tags                              = merge(var.azure_common_tags, {"service" = "app-insights-test" })
}

resource "azurerm_application_insights" "appinsights" {
  count                             = length(var.webapps)
  name                              = "insights-${var.webapps[count.index]}-${var.environment}"
  resource_group_name               = azurerm_resource_group.resourcegroup.name
  location                          = var.azure_location
  application_type                  = "web"
  depends_on                        = [azurerm_resource_group.resourcegroup]
  tags                              = merge(var.azure_common_tags, {"service" = "app-insights" })
}