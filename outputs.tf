output "publicIP" {
    value = "${azurerm_public_ip.test.ip_address}"
}

output "Login" {
    value = "ssh ${var.instance_admin}@${azurerm_public_ip.test.ip_address}"
}
