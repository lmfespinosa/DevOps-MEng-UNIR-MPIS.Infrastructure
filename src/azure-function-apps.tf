# https://www.terraform.io/docs/providers/azurerm/r/function_app.html

# FUNCTIONS_EXTENSION_VERSION not working.
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/3948
# https://github.com/terraform-providers/terraform-provider-azurerm/issues/1966#issuecomment-644998370

# Variables
# Any new function app should be set on terraform-devops-library.tf 
# Don't modify function apps order!!

variable "functionapps" {
    type                              = list(string)
    default                           = [ "user", "device" ]
}

# Resources

resource "azurerm_function_app" "functionapp" {
  count                               = length(var.functionapps)

  name                                = "fa-${var.functionapps[count.index]}-${var.azure_simplified_resource_group}-${var.environment}" # https://fa-appointment-portalv3-dev.azurewebsites.net
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  
  app_service_plan_id                 = azurerm_app_service_plan.functionappplan.id
  
  storage_account_name                = azurerm_storage_account.functionsstorage.name
  storage_account_access_key          = azurerm_storage_account.functionsstorage.primary_access_key
  
  tags                                = merge(var.azure_common_tags, {"service" = "function-app" })

  version                             = "~2"
    
  app_settings = {

    # function app configuration
    "WEBSITE_CONTENTSHARE"            = "fa-${var.functionapps[count.index]}-${var.azure_simplified_resource_group}-${var.environment}-content"
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = "${azurerm_application_insights.functioninsights[count.index].instrumentation_key}"
    "FUNCTIONS_EXTENSION_VERSION"     = "~2"
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "FUNCTIONS_WORKER_RUNTIME"        = "dotnet"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = true

    # azure sql configuration 
    "AzureSQLConnectionString"        = ""

    # event grid configuration
    "AzureEventGridClient.TopicKey"                     = ""
    "EventGridTopicEventPublisher.TopicEndPoint"        = ""
    "EventGridTopicEventPublisher.SubjectBasePath"      = ""
    "EventGridTopicEventPublisher.CheckEventValidity"   = ""
    "EventGridTopicEventPublisher.ThrowExceptions"      = ""

  }

  # https://github.com/terraform-providers/terraform-provider-azurerm/issues/1966#issuecomment-644998370
  lifecycle {
      ignore_changes                  = [
        app_settings["AzureSQLConnectionString"],
        
        app_settings["AzureEventGridClient.TopicKey"],
        app_settings["EventGridTopicEventPublisher.TopicEndPoint"],
        app_settings["EventGridTopicEventPublisher.SubjectBasePath"],
        app_settings["EventGridTopicEventPublisher.CheckEventValidity"],
        app_settings["EventGridTopicEventPublisher.ThrowExceptions"],
     ]
  }

  depends_on                          = [ azurerm_application_insights.functioninsights, 
                                        azurerm_app_service.publicspa]

  site_config  {
    cors {
      allowed_origins                 = [
        "https://${azurerm_app_service.publicspa.default_site_hostname}",
        
        "http://localhost:3000",
        "https://localhost:3001",
      ]
      support_credentials             = false
    }
  }

} 

resource "azurerm_function_app" "functionapptest" {
  count                               = var.environment == "dev" ? length(var.functionapps) : 0 # conditional creation

  name                                = "fa-${var.functionapps[count.index]}-${var.azure_simplified_resource_group}-${var.environment}-test" # https://fa-appointment-portalv3-dev.azurewebsites.net
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  
  app_service_plan_id                 = azurerm_app_service_plan.functionappplan.id
  
  storage_account_name                = azurerm_storage_account.functionsstorage.name
  storage_account_access_key          = azurerm_storage_account.functionsstorage.primary_access_key
  
  tags                                = merge(var.azure_common_tags, {"service" = "function-app" })

  version                             = "~2"
    
  app_settings = {

    # function app configuration
    "WEBSITE_CONTENTSHARE"            = "fa-${var.functionapps[count.index]}-${var.azure_simplified_resource_group}-${var.environment}-content"
    "APPINSIGHTS_INSTRUMENTATIONKEY"  = "${azurerm_application_insights.functioninsights_test[count.index].instrumentation_key}"
    "FUNCTIONS_EXTENSION_VERSION"     = "~2"
    "WEBSITE_RUN_FROM_PACKAGE"        = "1"
    "FUNCTIONS_WORKER_RUNTIME"        = "dotnet"
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = true

    # azure sql configuration 
    "AzureSQLConnectionString"        = ""

    # event grid configuration
    "AzureEventGridClient.TopicKey"                     = ""
    "EventGridTopicEventPublisher.TopicEndPoint"        = ""
    "EventGridTopicEventPublisher.SubjectBasePath"      = ""
    "EventGridTopicEventPublisher.CheckEventValidity"   = ""
    "EventGridTopicEventPublisher.ThrowExceptions"      = ""

  }

  # https://github.com/terraform-providers/terraform-provider-azurerm/issues/1966#issuecomment-644998370
  lifecycle {
      ignore_changes                  = [
        app_settings["AzureSQLConnectionString"],
        
        app_settings["AzureEventGridClient.TopicKey"],
        app_settings["EventGridTopicEventPublisher.TopicEndPoint"],
        app_settings["EventGridTopicEventPublisher.SubjectBasePath"],
        app_settings["EventGridTopicEventPublisher.CheckEventValidity"],
        app_settings["EventGridTopicEventPublisher.ThrowExceptions"],
     ]
  }

  depends_on                          = [ azurerm_application_insights.functioninsights_test, 
                                        azurerm_app_service.publicspa]

  site_config  {
    cors {
      allowed_origins                 = [
        "https://${azurerm_app_service.publicspa.default_site_hostname}",
        
        "http://localhost:3000",
        "https://localhost:3001",
      ]
      support_credentials             = false
    }
  }

} 
