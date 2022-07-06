variable "adc_snip" {
  description = "SNIP for ADC"
  type        = string
}

variable "adc_license" {
  description = "license name for ADC"
  type        = string
}

variable "adc_snip_subnet" {
  description = "SNIP subnet for ADC"
  type        = string
  default     = "255.255.255.0"
}
