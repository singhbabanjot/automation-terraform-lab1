#Creating Resource Group
resource "azurerm_resource_group" "network-rg" {
  name     = var.resource_group_name
  location = var.location
}

##Create Network Security Group ####
resource "azurerm_network_security_group" "network-nsg1" {
  name                = var.network_security_group_1
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  security_rule {
    name                       = "rule-for-ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "22"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_security_group" "network-nsg2" {
  name                = var.network_security_group_2
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  
 security_rule {
    name                       = "rule-for-3389"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "3389"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "rule-for-5985"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "5985"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  
  
}
## Create vNet ###
resource "azurerm_virtual_network" "network-vnet" {
  name                = var.vNet_name
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  address_space       = [var.vnet_address_space]

}

## Create Subnet 1
resource "azurerm_subnet" "network-subnet1" {
  name                 = var.subnet_1
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = [var.address_subnet_1]

}
## Create Subnet 2
resource "azurerm_subnet" "network-subnet2" {
  name                 = var.subnet_2
  resource_group_name  = azurerm_resource_group.network-rg.name
  virtual_network_name = azurerm_virtual_network.network-vnet.name
  address_prefixes     = [var.address_subnet_2]
}

##Attach Security Group to Subnet 1
resource "azurerm_subnet_network_security_group_association" "network-subnet1" {
  subnet_id                 = azurerm_subnet.network-subnet1.id
  network_security_group_id = azurerm_network_security_group.network-nsg1.id
}
##Attach Security Group to Subnet 2
resource "azurerm_subnet_network_security_group_association" "network-subnet2" {
  subnet_id                 = azurerm_subnet.network-subnet2.id
  network_security_group_id = azurerm_network_security_group.network-nsg2.id
}