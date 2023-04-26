output "u1_ssh_ip" {
  value = module.ubuntu1.ssh_ip
}
output "u1_ssh_key" {
  value     = module.ubuntu1.ssh_key
  sensitive = true
}
output "u1_ssh_key_pub" {
  value     = module.ubuntu1.ssh_key_pub
  sensitive = true
}
output "u1_ssh_config" {
  value = module.ubuntu1.ssh_config
}

output "u2_ssh_ip" {
  value = module.ubuntu2.ssh_ip
}
output "u2_ssh_key" {
  value     = module.ubuntu2.ssh_key
  sensitive = true
}
output "u2_ssh_key_pub" {
  value     = module.ubuntu2.ssh_key_pub
  sensitive = true
}
output "u2_ssh_config" {
  value = module.ubuntu2.ssh_config
}

output "cp_public_ip" {
  value = module.standalone-chkp.cp-public-ip
}
output "cp_pass" {
  sensitive = true
  value     = module.standalone-chkp.cp-pass
}

output "cp_login_cmd" {
  value     = "terraform output -raw cp_pass | clip.exe; ssh admin@${module.standalone-chkp.cp-pass}"
  sensitive = true
}