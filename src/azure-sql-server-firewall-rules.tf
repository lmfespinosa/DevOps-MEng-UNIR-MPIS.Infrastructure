# https://www.terraform.io/docs/providers/azurerm/r/sql_firewall_rule.html

# Variables

# Resources

resource "azurerm_sql_firewall_rule" "demo" {
  name                          = "firewall-rule-${var.environment}"
  resource_group_name           = azurerm_resource_group.resourcegroup.name
  server_name                   = azurerm_sql_server.sqlserver.name

  # start_ip_address              = chomp(data.http.current_ip.body)
  # end_ip_address                = chomp(data.http.current_ip.body)

  start_ip_address              = "1.1.1.1"
  end_ip_address                = "255.255.255.255"
}
