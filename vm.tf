resource "azurerm_virtual_machine" "test" {
  name                  = "${var.stack_name}-vm"
  location              = "${azurerm_resource_group.test.location}"
  resource_group_name   = "${azurerm_resource_group.test.name}"
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  delete_os_disk_on_termination = true


  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.vm_publisher}"
    offer     = "${var.vm_offer}"
    sku       = "${var.vm_sku}"
    version   = "${var.vm_version}"
  }
  storage_os_disk {
    name              = "${var.stack_name}-disk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "${var.instance_admin}"
    admin_password = "${var.instance_password}"
  }
  os_profile_linux_config {
    disable_password_authentication = false
   ssh_keys {
     path = "/home/${var.instance_admin}/.ssh/authorized_keys"
     key_data = "${file("${var.ssh_key}")}"

   }
  }
}

resource "azurerm_public_ip" "test" {
  #count               = "${var.instances}"
  name                = "${var.stack_name}-ip"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  allocation_method   = "Static"
  ip_version          = "IPv4"

}
