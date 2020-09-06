# https://www.terraform.io/docs/providers/azurerm/r/template_deployment.html
# https://blog.gripdev.xyz/2019/07/16/terraform-get-azure-function-key/

# Variables

# Resources

resource "azurerm_template_deployment" "function_keys" {  
  
  count                               = length(var.functionapps)
  name                                = "azfunc_mk_${azurerm_function_app.functionapp[count.index].name}_${random_string.random.result}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  parameters  = {
    "functionApp"                     = "${azurerm_function_app.functionapp[count.index].name}"
  }

  depends_on                          = [azurerm_function_app.functionapp]
  
  deployment_mode                     = "Incremental"

  template_body                       = <<BODY
  {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "functionApp": {"type": "string", "defaultValue": ""}
      },
      "variables": {
          "functionAppId": "[resourceId('Microsoft.Web/sites', parameters('functionApp'))]",
          "location": "[resourceGroup().location]"
      },
      "resources": [

      ],
      "outputs": {
          "functionkey": {
              "type": "string",
              "value": "[listkeys(concat(variables('functionAppId'), '/host/default'), '2018-11-01').masterKey]"                                                                                
          }
      }
  }
  BODY

}

resource "azurerm_template_deployment" "function_keys_test" {  
  
  count                               = length(var.functionapps)
  name                                = "azfunc_mk_test_${azurerm_function_app.functionapp[count.index].name}_${random_string.random.result}"
  resource_group_name                 = azurerm_resource_group.resourcegroup.name
  parameters  = {
    "functionApp"                     = "${azurerm_function_app.functionapptest[count.index].name}"
  }

  depends_on                          = [azurerm_function_app.functionapptest]

  deployment_mode                     = "Incremental"

  template_body                       = <<BODY
  {
      "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
          "functionApp": {"type": "string", "defaultValue": ""}
      },
      "variables": {
          "functionAppId": "[resourceId('Microsoft.Web/sites', parameters('functionApp'))]",
          "location": "[resourceGroup().location]"
      },
      "resources": [

      ],
      "outputs": {
          "functionkey": {
              "type": "string",
              "value": "[listkeys(concat(variables('functionAppId'), '/host/default'), '2018-11-01').masterKey]"                                                                                
          }
      }
  }
  BODY

}

output "func_keys" {
  value = "${lookup(azurerm_template_deployment.function_keys.outputs, "functionkey")}"
}

#resource "azurerm_template_deployment" "function_keys_slot" {  
  
#  count                               = length(var.functionapps)
#  name                                = "azfunc_mk_slot_${azurerm_function_app.functionapp[count.index].name}_${random_string.random.result}"
#  resource_group_name                 = azurerm_resource_group.resourcegroup.name
#  parameters  = {
#    "functionApp"                     = azurerm_function_app.functionapp[count.index].name
#  }

#   depends_on                          = [azurerm_function_app.functionappslot]
  
#   deployment_mode                     = "Incremental"


#   template_body                       = <<BODY
#   {
#       "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
#       "contentVersion": "1.0.0.0",
#       "parameters": {
#           "functionApp": {"type": "string", "defaultValue": ""}
#       },
#       "variables": {
#           "functionAppId": "[resourceId('Microsoft.Web/sites/slots', parameters('functionApp'), 'test-slot')]",
#           "location": "[resourceGroup().location]"
#       },
#       "resources": [

#       ],
#       "outputs": {
#           "functionkey": {
#               "type": "string",
#               "value": "[listkeys(concat(variables('functionAppId'), '/host/default'), '2018-11-01').masterKey]"
#           }

#       }
        
#   }
#   BODY

# }

