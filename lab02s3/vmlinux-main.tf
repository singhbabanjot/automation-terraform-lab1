resource "azurerm_network_interface" "nic" {
  name                = "${var.linux_name}-nic"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name

  ip_configuration {
    name                          = "${var.linux_name}-ipconfig"
    subnet_id                     = azurerm_subnet.network-subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}
resource "azurerm_public_ip" "public_ip" {
  name                = "${var.linux_name}-pip"
  location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  allocation_method   = "Dynamic"
  domain_name_label = "${var.linux_name}"

}
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "${var.linux_name}"
   location            = azurerm_resource_group.network-rg.location
  resource_group_name = azurerm_resource_group.network-rg.name
  admin_username      = "${var.admin_username}"
  size                = "${var.size}"
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  admin_ssh_key {
    username   = "${var.admin_username}"
    public_key = file("${var.public_key}")
  }

  os_disk {
    caching              = "${var.os_disk[0].caching}"
    storage_account_type = "${var.os_disk[0].storage_account_type}"
  }

  source_image_reference {
    publisher = "${var.os_info[0].publisher}"
    offer     = "${var.os_info[0].offer}"
    sku       = "${var.os_info[0].sku}"
    version   = "${var.os_info[0].version}"
  }
}