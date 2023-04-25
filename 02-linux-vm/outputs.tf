output "ssh_ip" {
  value = azurerm_linux_virtual_machine.linuxvm.public_ip_address
}
output "ssh_key" {
  value     = tls_private_key.linux_ssh.private_key_pem
  sensitive = true
}
output "ssh_key_pub" {
  value     = tls_private_key.linux_ssh.public_key_openssh
  sensitive = true
}