resource "azurerm_virtual_network" "test" {
  name                = "${var.stack_name}-network"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location            = "${azurerm_resource_group.test.location}"
  address_space       = ["${var.vnet_cidr}"]
}

resource "azurerm_subnet" "test" {
  count = "${var.instances}"
  name                 = "${var.stack_name}.${count.index +1}"
  resource_group_name  = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix       = "${var.subnet_cidr[count.index]}"
}

resource "azurerm_network_security_group" "test" {

  name                = "${var.stack_name}-nsg"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
}

resource "azurerm_network_security_rule" "test" {
  count = "${length(var.port_number)}"

  name                        = "rule-${count.index}-port${var.port_number[count.index]}"
  priority                    = "${100 + count.index * 2}"
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "${var.port_number[count.index]}"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"

  resource_group_name         = "${azurerm_resource_group.test.name}"
  network_security_group_name = "${azurerm_network_security_group.test.name}"
}

resource "azurerm_network_interface" "test" {
  name                = "${var.stack_name}-nic"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = "${azurerm_subnet.test.0.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = "${azurerm_public_ip.test.id}"
  }
}

resource "azurerm_subnet_network_security_group_association" "test" {
  subnet_id                 = "${azurerm_subnet.test.id}"
  network_security_group_id = "${azurerm_network_security_group.test.id}"
}
