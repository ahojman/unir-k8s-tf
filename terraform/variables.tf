variable "azure_spn_id" {
  description = "Azure SPN ID"
  type        = string
  sensitive   = true
}
variable "azure_spn_secret" {
  description = "Azure SPN Secret"
  type        = string
  sensitive   = true
}
variable "azure_tenant" {
  description = "Azure Tenant ID"
  type        = string
  sensitive   = true
}
variable "azure_sub_id" {
  description = "Azure Subscription ID"
  type        = string
  sensitive   = true
}

# variable "location" {
#   default = "westeurope"
# }

variable "vm_role" {
  type    = list(string)
  default = ["k8s-node1", "k8s-node2"]
}
variable "vm_size_nodes" {
  type    = string
  default = "Standard_B2s"
}

variable "vm_size_master" {
  type    = string
  default = "Standard_D2s_v3"
}