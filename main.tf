terraform {
  required_version = ">= 1.0.0"
  required_providers {
    citrixadc = {
      source                = "citrix/citrixadc"
      version               = "~> 1.17.0"
      configuration_aliases = [citrixadc.pre, citrixadc.post]
    }
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.0.2"
    }
  }
}


provider "citrixadc" {
  endpoint = "http://${module.build.vm_ip}"
  alias    = "pre"
}

provider "citrixadc" {
  endpoint = "http://${module.build.vm_ip}"
  alias    = "config"
  username = "nsroot"
  password = local.adc_password
}

provider "vsphere" {
  user           = "administrator@vsphere.local"
  password       = "myvcenterpass"
  vsphere_server = "vcenter01.lab.local"
  # If you have a self-signed cert
  allow_unverified_ssl = true
}

locals {
  #What to set the ADC password to after deployment
  adc_password = "mynewnsrootpassword"
}


#Deploys ADC VM
module "build" {
  source = "./build"
  #vsphere connection info
  vm_host            = "192.168.1.247"
  vsphere_datacenter = "DC01"
  vsphere_datastore  = "NUC01"

  #Resource Pool (If no resource pool place in CLUSTER/Resources format)
  vsphere_rp = "192.168.1.247/Resources"

  #Path to ADC OVF File
  ovf = "${path.module}\\ovf\\NSVPX-ESX-13.1-24.38_nc_64.ovf"

  #Static MAC to use for ADC license
  vm_mac = "00:50:56:9b:98:a6"

  #ADC information
  vm_network = "VLAN2"
  vm_ip      = "192.168.2.66"
  vm_gateway = "192.168.2.254"
  vm_netmask = "255.255.255.0"
  vm_name    = "adc-test-1"

}

#Set the initial password of the ADC
module "password" {
  source       = "./password"
  providers    = { citrixadc = citrixadc.pre }
  adc_password = local.adc_password
}

#Configures the ADC
module "config" {
  source    = "./config"
  providers = { citrixadc = citrixadc.config }

  #Location of License file
  adc_license = "${path.module}/mylicense.lic"

  #ADC subnet IP
  adc_snip = "192.168.2.68"
}
