variable "vsphere_datacenter" {
  description = "vsphere datacenter"
  type        = string
}

variable "vsphere_datastore" {
  description = "vsphere datastore to deploy"
  type        = string
}

variable "vsphere_rp" {
  description = "vsphere resource pool"
  type        = string
}


variable "vm_network" {
  description = "vsphere network for deployed vm"
  type        = string
}

variable "vm_ip" {
  description = "IP of linux VM"
  type        = string
}

variable "vm_gateway" {
  description = "Gateway of linux VM"
  type        = string
}

variable "vm_netmask" {
  description = "Subnet mask of VM network"
  type        = string
}

variable "vm_annotation" {
  description = "Note to apply to VM"
  type        = string
  default     = "BUILT BY TERRAFORM"
}

variable "vm_name" {
  description = "Name for linux VM"
  type        = string
}

variable "vm_folder" {
  description = "Folder path to place VM"
  type        = string
  default     = null
}

variable "vm_host" {
  description = "Host to import OVF"
  type        = string
}

variable "ovf" {
  description = "OVF file to deploy"
  type        = string
}

variable "vm_mac" {
  description = "Static value of MAC address"
  type        = string
}
