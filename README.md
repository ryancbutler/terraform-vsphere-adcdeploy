# Terraform Citrix ADC vSphere Deploy

Deploys a basic Citrix ADC OVF to vSphere using Terraform

## Pre-Reqs

  1. [Download](https://www.citrix.com/downloads/citrix-adc/) OVF files and place in *ovf* dir
  2. Obtain Citrix ADC license for MAC address
  3. Adjust *main.tf* to reflect environment

## To Deploy

Run the following

```powershell
terraform init
#Work around for changing password
terraform apply -auto-approve -target="module.build" && start-sleep -seconds 20 && terraform apply -auto-approve -target="module.password" && terraform apply -auto-approve -target="module.config"
```

## To Destroy

```powershell
terraform destroy -auto-approve
```
