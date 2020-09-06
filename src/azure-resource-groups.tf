# https://www.terraform.io/docs/providers/azurerm/r/resource_group.html

# Variables

variable "azure_resource_group" {
    type                              = string
    default                           = "mpis"
}

variable "azure_simplified_resource_group" {
    type                              = string
    default                           = "mpis"
}


# Resources

resource "azurerm_resource_group" "resourcegroup" {
  name                                = "${var.azure_resource_group}_${var.environment}"
  location                            = var.azure_location
  tags                                = merge(var.azure_common_tags, {"service" = "resource-group" })
}
