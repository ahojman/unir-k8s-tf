resource "azurerm_linux_virtual_machine" "vm" {

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size_nodes

  name  = var.vm_role[count.index]
  count = length(var.vm_role)

  admin_username                  = "azureadmin"
  network_interface_ids           = [azurerm_network_interface.vm_nic[count.index].id]
  disable_password_authentication = true

    admin_ssh_key {
      username   = "azureadmin"
      public_key = file("~/.ssh/unir-azure.pub")
    }

    os_disk {
      caching              = "ReadWrite"
      storage_account_type = "Standard_LRS"
    }

    plan {
      name      = "centos-8-stream-free"
      product   = "centos-8-stream-free"
      publisher = "cognosys"
    }

    source_image_reference {
      publisher = "cognosys"
      offer     = "centos-8-stream-free"
      sku       = "centos-8-stream-free"
      version   = "1.2019.0810"
    }
}

resource "azurerm_network_interface" "vm_nic" {
  name                = "nic-${var.vm_role[count.index]}"
  count               = length(var.vm_role)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "conf-${var.vm_role[count.index]}"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.${count.index + 6}"
    public_ip_address_id          = azurerm_public_ip.vm_pip[count.index].id
  }
}
resource "azurerm_public_ip" "vm_pip" {
  name                = "pip-${var.vm_role[count.index]}"
  count               = length(var.vm_role)
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}