terraform {
  required_version = ">= 1.0.0"
  required_providers {
    citrixadc = {
      source  = "citrix/citrixadc"
      version = "~>1.17.0"
    }
  }
}

resource "citrixadc_password_resetter" "tf_resetter" {
  username     = "nsroot"
  password     = "nsroot"
  new_password = var.adc_password
}

