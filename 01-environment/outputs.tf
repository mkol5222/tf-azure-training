output "linux-subnet-id" {
    value = azurerm_subnet.linux-subnet.id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "virtual_network_name" {
  value = var.virtual_network_name
}