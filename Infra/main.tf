# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a Resource Group
resource "azurerm_resource_group" "testrg" {
  name     = "testrg"
  location = "eastus2"
}
 
# Create 3 different Network Security Groups
resource "azurerm_network_security_group" "testnsg" {
  count = 3
  name                = var.nsg_names[count.index]
  location            = "eastus2"
  resource_group_name = azurerm_resource_group.testrg.name
 
}
 
# Define the rules for the first NSG
resource "azurerm_network_security_rule" "testrules1" {
  for_each                    = local.nsgrules 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.testrg.name
  network_security_group_name = var.nsg_names[0]
  depends_on = [azurerm_network_security_group.testnsg]
}

# Define the rules for the second NSG
resource "azurerm_network_security_rule" "testrules2" {
  for_each                    = local.nsgrules2 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.testrg.name
  network_security_group_name = var.nsg_names[1]
  depends_on = [azurerm_network_security_group.testnsg]
}

# Define the rules for the third NSG
resource "azurerm_network_security_rule" "testrules3" {
  for_each                    = local.nsgrules 
  name                        = each.key
  direction                   = each.value.direction
  access                      = each.value.access
  priority                    = each.value.priority
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.testrg.name
  network_security_group_name = var.nsg_names[2]
  depends_on = [azurerm_network_security_group.testnsg]
}
