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