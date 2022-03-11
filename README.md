# Azure + Terraform + Ansible + Kubernetes

### Requirements
- Ansible (steps available to install [here])
- Terraform (binary's here for download [link])
- An Azure Service Principal and its secret (more [information] on how to generate it)

[here]: https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#installing-ansible-on-specific-operating-systems
[link]: https://www.terraform.io/downloads
[information]: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret

### :sparkles: Tip
Create a `terraform.tfvars` file inside the `terraform/` directory, with the following content:
```
azure_spn_id     = "YOUR-AZURE-SPN-APPID"
azure_spn_secret = "YOUR-AZURE-SPN-SECRET"
azure_tenant     = "YOUR-AZURE-TENANT"
azure_sub_id     = "YOUR-AZURE-SUBSCRIPTION-ID"
```
This will help the automation to reach Azure Cloud directly. 🔐

### ⏲️ Quick Usage Guide

1. Clone this repo on your local.
2. Execute `./deploy-infra.sh` script to trigger Terraform and create Azure components.
3. Wait some minutes for its completion.
4. A new file will be generated on your directory, called `outputs.txt`; it will have the IP addresses for the whole Environment
5. Use these IPs to replace on Ansible [hosts] file.
6. Execute `./ansible/deploy.sh` script in order to do the Provision of Kubernetes and associated resources.

[hosts]: https://github.com/ahojman/unir-k8s-tf/blob/main/ansible/hosts
