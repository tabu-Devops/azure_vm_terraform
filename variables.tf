variable "stack_name" {
    description = "Name of the Stack"
    default = "terraform" 
}

variable "resource_group" {
    description = "Name of the Azure Resource Group"
    default = "terra_RG"
}

variable "vnet_location" {
    description = "Location of the Azure Vnet"
    default = "West US"
}

variable "vnet_cidr" {
    description = "CIDR of the VNET"
    default = "10.0.0.0/16"
}
 
variable "subnet_cidr" {
    description = "Subnet CIDR blocks"
    type = "list"
    default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
}

variable "instances" {
     default = 1
     description = "No of instances"
}
variable "vm_size" {
    description = "Size of the VM"
    default = "Standard_DS1_v2"
}

variable "instance_admin" {
    description = "User of the vm"
    default = "testadmin"
}

variable "instance_password"{
    description = "Password for the testadmin user"
    default = "Password1234!"
}

variable "ssh_key" {
    default = "~/.ssh/id_rsa.pub"
    description = "Path to the public key to be used for ssh access to the VM"
}

variable "vm_publisher"{
    description = "Publisher of the VM"
    default = "RedHat"
}

variable "vm_offer"{
    description = "offer of the VM"
    default = "RHEL"
}

variable "vm_sku"{
    description = "Sku of the VM"
    default = "7.5"
}

variable "vm_version"{
    description = "version of the VM"
    default = "7.5.2018081519"
}

variable "port_number" {
  description = "Remote tcp port to be used for access to the vms created via the nsg applied to the nics."
  default = ["22"]
  type = "list"
}
