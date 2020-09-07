# https://www.terraform.io/docs/providers/azurerm/r/eventgrid_topic.html

# Variables
# Any new topic should be set on terraform-devops-library.tf 

# variable "topics" {
#     type                              = list(string)
#     default                           = [ "device", "user"]
# }


# Resources

resource "azurerm_eventgrid_topic" "topic_user" {
   name                                = "topic-user-${var.environment}"
   resource_group_name                 = azurerm_resource_group.resourcegroup.name
   location                            = var.azure_location
   tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
   input_mapping_fields = {
       topic = "user"
   }
 }

 resource "azurerm_eventgrid_topic" "topic_user_test" {
   name                                = "topic-test-user-${var.environment}"
   resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
  input_mapping_fields = {
       topic = "user"
   }
}

resource "azurerm_eventgrid_topic" "topic_device" {
   name                                = "topic-device-${var.environment}"
   resource_group_name                 = azurerm_resource_group.resourcegroup.name
   location                            = var.azure_location
   tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
   input_mapping_fields = {
       topic = "device"
   }
 }

 resource "azurerm_eventgrid_topic" "topic_device_test" {
   name                                = "topic-test-device-${var.environment}"
   resource_group_name                 = azurerm_resource_group.resourcegroup.name
  location                            = var.azure_location
  tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
  input_mapping_fields = {
       topic = "device"
   }
}