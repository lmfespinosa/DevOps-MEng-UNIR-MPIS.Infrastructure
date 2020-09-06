# https://www.terraform.io/docs/providers/azurerm/r/eventgrid_topic.html

# Variables
# Any new topic should be set on terraform-devops-library.tf 

variable "topics" {
    type                              = list(string)
    default                           = [ "device", "user"]
}


# Resources

# resource "azurerm_eventgrid_topic" "topic" {
#   count                               = length(var.topics)
#   name                                = "topic-${var.topics[count.index]}-${var.environment}"
#   resource_group_name                 = azurerm_resource_group.resourcegroup.name
#   location                            = var.azure_location
#   tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
# }

# resource "azurerm_eventgrid_topic" "topic_test" {
#   count                               = length(var.topics)
#   name                                = "topic-test-${var.topics[count.index]}-${var.environment}"
#   resource_group_name                 = azurerm_resource_group.resourcegroup.name
#   location                            = var.azure_location
#   tags                                = merge(var.azure_common_tags, {"service" = "event-grid-topic" })
# }