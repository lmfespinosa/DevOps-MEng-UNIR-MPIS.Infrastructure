# https://www.terraform.io/docs/providers/azuredevops/r/variable_group.html

# Variables

# Resources

resource "azuredevops_variable_group" "variablegroup" {
  project_id                          = data.azuredevops_project.project.id
  name                                = "TERRAFORM_${upper(var.environment)}"
  description                         = "Terraform managed resources for ${upper(var.environment)} environment. Don't modify any value yourself!"
  allow_access                         = true

  depends_on                          = [azurerm_template_deployment.function_keys,
                                        azurerm_template_deployment.function_keys_test,
                                        azurerm_sql_server.sqlserver,
                                        azurerm_eventgrid_topic.topic,
                                        azurerm_eventgrid_topic.topic_test]


  # ------------------------------------------------------------------------------------
  # Resource group
  # ------------------------------------------------------------------------------------

  variable {
    name                              = "RESOURCE_GROUP_${upper(var.environment)}"
    value                             = azurerm_resource_group.resourcegroup.name
  }

  # ------------------------------------------------------------------------------------
  # Storage
  # ------------------------------------------------------------------------------------

  # variable {
  #   name                              = "AZURE_STORAGE_MAIN_PRIMARY_CONNECTION_STRING_${upper(var.environment)}"
  #   value                             = azurerm_storage_account.mainstorage.primary_connection_string
  # }

  # variable {
  #   name                              = "AZURE_STORAGE_MAIN_SECONDARY_CONNECTION_STRING_${upper(var.environment)}"
  #   value                             = azurerm_storage_account.mainstorage.secondary_connection_string 
  # }


  # ------------------------------------------------------------------------------------
  # Web apps
  # ------------------------------------------------------------------------------------

  # 0
  variable {
    name                              = "APP_${upper(var.webapps[0])}_HOSTNAME_${upper(var.environment)}"
    value                             = "https://${azurerm_app_service.publicspa.default_site_hostname}"
  }

  variable {
    name                              = "APP_${upper(var.webapps[0])}_NAME_${upper(var.environment)}"
    value                             = azurerm_app_service.publicspa.name
  }

  # ------------------------------------------------------------------------------------
  # SQL Server
  # ------------------------------------------------------------------------------------

  variable {
    name                              = "SQL_SERVER_USER_${upper(var.environment)}"
    value                             = var.azure_sql_server_username
  }

  variable {
    name                              = "SQL_SERVER_PASSWORD_${upper(var.environment)}"
    value                             = azurerm_sql_server.sqlserver.administrator_login_password
    # is_secret                         = true
  }

  variable {
    name                              = "SQL_SERVER_NAME_${upper(var.environment)}"
   value                             = azurerm_sql_server.sqlserver.name
  }

  variable {
    name                              = "SQL_SERVER_FULLNAME_${upper(var.environment)}"
    value                             = "${azurerm_sql_server.sqlserver.name}.database.windows.net"
  }

  # ------------------------------------------------------------------------------------
  # SQL databases
  # ------------------------------------------------------------------------------------

  # 0
  variable {
    name                              = "SQL_SERVER_DATABASE_${upper(var.databases[0])}_CONNECTION_STRING_${upper(var.environment)}"
    value                             = "Server=tcp:${azurerm_sql_server.sqlserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_sql_database.database[0].name};Persist Security Info=False;User ID=${var.azure_sql_server_username};Password=${azurerm_sql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    # is_secret                         = true
  }

  # 1
  variable {
    name                              = "SQL_SERVER_DATABASE_${upper(var.databases[1])}_CONNECTION_STRING_${upper(var.environment)}"
    value                             = "Server=tcp:${azurerm_sql_server.sqlserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_sql_database.database[1].name};Persist Security Info=False;User ID=${var.azure_sql_server_username};Password=${azurerm_sql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    # is_secret                         = true
  }

  # ------------------------------------------------------------------------------------
  # SQL test databases
  # ------------------------------------------------------------------------------------

  # 0
  variable {
    name                              = "SQL_SERVER_DATABASE_TEST_${upper(var.databases[0])}_CONNECTION_STRING_${upper(var.environment)}"
    value                             = "Server=tcp:${azurerm_sql_server.sqlserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_sql_database.testdatabase[0].name};Persist Security Info=False;User ID=${var.azure_sql_server_username};Password=${azurerm_sql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"     # is_secret                         = true
  }

  # 1
  variable {
    name                              = "SQL_SERVER_DATABASE_TEST_${upper(var.databases[1])}_CONNECTION_STRING_${upper(var.environment)}"
    value                             = "Server=tcp:${azurerm_sql_server.sqlserver.name}.database.windows.net,1433;Initial Catalog=${azurerm_sql_database.testdatabase[1].name};Persist Security Info=False;User ID=${var.azure_sql_server_username};Password=${azurerm_sql_server.sqlserver.administrator_login_password};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
    # is_secret                         = true
  }

  # ------------------------------------------------------------------------------------
  # Function app (name, hostname, master key, and "key/path" combination)
  # ------------------------------------------------------------------------------------

  # 0
  variable {
    name                              = "FUNCTION_${upper(var.functionapps[0])}_HOSTNAME_${upper(var.environment)}"
    value                             = "https://${azurerm_function_app.functionapp[0].default_hostname}"
  }

  variable {
    name                              = "FUNCTION_${upper(var.functionapps[0])}_NAME_${upper(var.environment)}"
    value                             = azurerm_function_app.functionapp[0].name
  }

  variable {
     name                              = "FUNCTION_${upper(var.functionapps[0])}_MASTER_KEY_${upper(var.environment)}"
     value                             = lookup(azurerm_template_deployment.function_keys[0].outputs, "functionkey")
     # is_secret                         = true
   }

   variable {
     name                              = "FUNCTION_${upper(var.functionapps[0])}_KEY_PATH_${upper(var.environment)}"
     value                             = "key=${lookup(azurerm_template_deployment.function_keys[0].outputs, "functionkey")};path=https://${azurerm_function_app.functionapp[0].default_hostname}"
     # is_secret                         = true
   }


  # 1
  variable {
    name                              = "FUNCTION_${upper(var.functionapps[1])}_HOSTNAME_${upper(var.environment)}"
    value                             = "https://${azurerm_function_app.functionapp[1].default_hostname}"
  }

  variable {
    name                              = "FUNCTION_${upper(var.functionapps[1])}_NAME_${upper(var.environment)}"
    value                             = azurerm_function_app.functionapp[1].name
  }  

   variable {
     name                              = "FUNCTION_${upper(var.functionapps[1])}_MASTER_KEY_${upper(var.environment)}"
     value                             = lookup(azurerm_template_deployment.function_keys[1].outputs, "functionkey")
     # is_secret                         = true
   }

   variable {
     name                              = "FUNCTION_${upper(var.functionapps[1])}_KEY_PATH_${upper(var.environment)}"
     value                             = "key=${lookup(azurerm_template_deployment.function_keys[1].outputs, "functionkey")};path=https://${azurerm_function_app.functionapp[1].default_hostname}"
     # is_secret                         = true
   }

  # ------------------------------------------------------------------------------------
  # Function app Test (name, hostname, master key, and "key/path" combination)
  # ------------------------------------------------------------------------------------

  # 0
  variable {
    name                              = "FUNCTION_TEST_${upper(var.functionapps[0])}_HOSTNAME_${upper(var.environment)}"
    value                             = "https://${azurerm_function_app.functionapptest[0].default_hostname}"
  }

  variable {
    name                              = "FUNCTION_TEST_${upper(var.functionapps[0])}_NAME_${upper(var.environment)}"
    value                             = azurerm_function_app.functionapptest[0].name
  }

  variable {
     name                              = "FUNCTION_TEST_${upper(var.functionapps[0])}_MASTER_KEY_${upper(var.environment)}"
     value                             = lookup(azurerm_template_deployment.function_keys_test[0].outputs, "functionkey")
     # is_secret                         = true
   }

   variable {
     name                              = "FUNCTION_TEST_${upper(var.functionapps[0])}_KEY_PATH_${upper(var.environment)}"
     value                             = "key=${lookup(azurerm_template_deployment.function_keys_test[0].outputs, "functionkey")};path=https://${azurerm_function_app.functionapptest[0].default_hostname}"
     # is_secret                         = true
   }


  # 1
  variable {
    name                              = "FUNCTION_TEST_${upper(var.functionapps[1])}_HOSTNAME_${upper(var.environment)}"
    value                             = "https://${azurerm_function_app.functionapptest[1].default_hostname}"
  }

  variable {
    name                              = "FUNCTION_TEST_${upper(var.functionapps[1])}_NAME_${upper(var.environment)}"
    value                             = azurerm_function_app.functionapptest[1].name
  }  

   variable {
     name                              = "FUNCTION_TEST_${upper(var.functionapps[1])}_MASTER_KEY_${upper(var.environment)}"
     value                             = lookup(azurerm_template_deployment.function_keys_test[1].outputs, "functionkey")
     # is_secret                         = true
   }

   variable {
     name                              = "FUNCTION_TEST_${upper(var.functionapps[1])}_KEY_PATH_${upper(var.environment)}"
     value                             = "key=${lookup(azurerm_template_deployment.function_keys_test[1].outputs, "functionkey")};path=https://${azurerm_function_app.functionapptest[1].default_hostname}"
     # is_secret                         = true
   }

  # ------------------------------------------------------------------------------------
  # Event grid
  # ------------------------------------------------------------------------------------

  # 0 user

  variable {
    name                              = "EVENT_GRID_${upper(var.topics[0])}_TOPIC_ID_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[0].id
  }


  variable {
    name                              = "EVENT_GRID_${upper(var.topics[0])}_TOPIC_ENDPOINT_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[0].endpoint
  }

  variable {
    name                              = "EVENT_GRID_${upper(var.topics[0])}_TOPIC_PRIMARY_KEY_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[0].primary_access_key
    # is_secret                         = true
  } 

 #1 device
 variable {
   name                              = "EVENT_GRID_${upper(var.topics[1])}_TOPIC_ID_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[1].id
  }


  variable {
    name                              = "EVENT_GRID_${upper(var.topics[1])}_TOPIC_ENDPOINT_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[1].endpoint
  }

  variable {
    name                              = "EVENT_GRID_${upper(var.topics[1])}_TOPIC_PRIMARY_KEY_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic[1].primary_access_key
    # is_secret                         = true
  } 

  # ------------------------------------------------------------------------------------
  # Event grid Test
  # ------------------------------------------------------------------------------------

  # 0 user

  variable {
    name                              = "EVENT_GRID_TEST_${upper(var.topics[0])}_TOPIC_ID_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[0].id
  }


  variable {
    name                              = "EVENT_GRID_TEST_${upper(var.topics[0])}_TOPIC_ENDPOINT_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[0].endpoint
  }

  variable {
    name                              = "EVENT_GRID_TEST_${upper(var.topics[0])}_TOPIC_PRIMARY_KEY_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[0].primary_access_key
    # is_secret                         = true
  } 

 #1 device
 variable {
   name                              = "EVENT_GRID_TEST_${upper(var.topics[1])}_TOPIC_ID_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[1].id
  }


  variable {
    name                              = "EVENT_GRID_TEST_${upper(var.topics[1])}_TOPIC_ENDPOINT_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[1].endpoint
  }

  variable {
    name                              = "EVENT_GRID_TEST_${upper(var.topics[1])}_TOPIC_PRIMARY_KEY_${upper(var.environment)}"
    value                             = azurerm_eventgrid_topic.topic_test[1].primary_access_key
    # is_secret                         = true
  } 

}
 