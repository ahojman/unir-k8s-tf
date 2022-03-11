resource "azurerm_linux_virtual_machine" "vm_master" {

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size_master

  name = "k8s-master"

  admin_username                  = var.ssh_user
  network_interface_ids           = [azurerm_network_interface.vm_nic_master.id]
  disable_password_authentication = true

  admin_ssh_key {
    username   = var.ssh_user
    public_key = file(var.public_key_path)
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

resource "azurerm_network_interface" "vm_nic_master" {
  name = "nic-k8s-master"

  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "conf-k8s-master"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5" # Hardcoded IP, for easy allocation
    public_ip_address_id          = azurerm_public_ip.vm_pip_master.id
  }
}
resource "azurerm_public_ip" "vm_pip_master" {
  name                = "pip-k8s-master"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"
}