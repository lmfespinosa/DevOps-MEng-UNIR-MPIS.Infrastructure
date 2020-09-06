# service plan
resource "azurerm_app_service_plan" "functionappplan" {
  name                                = "plan-functions-${var.environment}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  kind                                = "FunctionApp"
  tags                                = merge(var.azure_common_tags, {"service" = "service-plan" })

  sku {    
    tier = "Dynamic"
    size = "Y1"
    capacity = 0
  }
}

resource "azurerm_app_service_plan" "appserviceplanbasic" {
  name                                = "plan-app-services-${var.environment}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  tags                                = merge(var.azure_common_tags, {"service" = "service-plan" })

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service_plan" "appserviceplusplan" {
  name                                = "plan-app-services-plus-${var.environment}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  tags                                = merge(var.azure_common_tags, {"service" = "service-plan" })

  sku {
    tier = "Standard"
    size = "S1"
  }
}