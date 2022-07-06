terraform {
  required_version = ">= 1.0.0"
  required_providers {
    citrixadc = {
      source  = "citrix/citrixadc"
      version = "~>1.17.0"
    }
  }
}

resource "citrixadc_nsip" "snip" {
  ipaddress = var.adc_snip
  type      = "SNIP"
  netmask   = var.adc_snip_subnet
  icmp      = "ENABLED"
}


resource "citrixadc_nsconfig_save" "tf_ns_save" {
  all                     = true
  timestamp               = timestamp()
  concurrent_save_ok      = true
  concurrent_save_retries = 5
  depends_on = [
    citrixadc_nsip.snip,
    citrixadc_systemfile.license
  ]
}

resource "citrixadc_systemfile" "license" {
  filename     = var.adc_license
  filelocation = "/nsconfig/license"
  filecontent  = file(var.adc_license)
}

resource "citrixadc_rebooter" "tf_rebooter" {
  timestamp            = timestamp()
  warm                 = true
  wait_until_reachable = true
  depends_on = [
    citrixadc_nsconfig_save.tf_ns_save
  ]
}
