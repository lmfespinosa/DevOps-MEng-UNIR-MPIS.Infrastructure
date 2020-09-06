# https://www.terraform.io/docs/providers/azurerm/r/app_service.html

# Variables 
# Any new function app should be set on terraform-devops-library.tf 
# Don't modify web apps order!!

variable "webapps" {
    type                              = list(string)
    default                           = ["publicspa"]
}

# Resources

# Public SPA

resource "azurerm_app_service" "publicspa" {
  name                                = "app-${var.webapps[0]}-${var.azure_simplified_resource_group}-${var.environment}" 
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  app_service_plan_id                 = azurerm_app_service_plan.appserviceplanbasic.id
  tags                                = merge(var.azure_common_tags, {"service" = "app-service", "plan" = "basic" })
  depends_on                          = [azurerm_application_insights.appinsights]

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = "${azurerm_application_insights.appinsights[0].instrumentation_key}"
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "FUNCTIONS_WORKER_RUNTIME"        = "dotnet"
    "IAC"                             = "Terraform" 
    "VENDOR"                          = "Luis Miguel" 
  }

}
