
output "master_pip" {
  description = "Public IP for Master Node"
  value       = join(",", azurerm_linux_virtual_machine.vm_master.*.public_ip_address)
}

output "nodes_pip" {
  description = "Public IP for Node Pool"
  value       = join(",", azurerm_linux_virtual_machine.vm.*.public_ip_address)
}

