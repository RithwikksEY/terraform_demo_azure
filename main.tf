provider "azurerm" {
  features {}
}
 
resource "azurerm_resource_group" "example" {
  name     = "rg-hcp-terraform-test"
  location = "East US"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-demo"
  address_space       = ["10.0.0.0/16"]
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name
}
 
resource "azurerm_subnet" "subnet" {
  name                 = "subnet-demo"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}
 
resource "azurerm_network_interface" "nic" {
depends_on = [azurerm_network_interface.nic]

  name                = "nic-demo"
  location            = "East US"
  resource_group_name = azurerm_resource_group.example.name
 
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}
 
resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-demo"
  resource_group_name = azurerm_resource_group.example.name
  location            = "East US"
  size                = "Standard_B1ms"
  admin_username      = "azureuser"
 
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]
 
  admin_password = "Password1234!"
  disable_password_authentication = false
 
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
 
  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}
