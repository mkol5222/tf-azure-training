module "environment" {
  source          = "./01-environment"
  client_secret   = var.client_secret
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
  route_through_firewall = true
}

module "ubuntu1" {
  depends_on = [
    module.environment.linux-subnet-id
  ]
  source               = "./02-linux-vm"
  client_secret        = var.client_secret
  client_id            = var.client_id
  tenant_id            = var.tenant_id
  subscription_id      = var.subscription_id
  resource_group_name  = module.environment.resource_group_name
  linux-subnet-name    = "linux-subnet"
  virtual_network_name = module.environment.virtual_network_name
  vm_name              = "ubuntu1"
}

module "ubuntu2" {
  depends_on = [
    module.environment.linux-subnet-id
  ]
  source               = "./02-linux-vm"
  client_secret        = var.client_secret
  client_id            = var.client_id
  tenant_id            = var.tenant_id
  subscription_id      = var.subscription_id
  resource_group_name  = module.environment.resource_group_name
  linux-subnet-name    = "linux-subnet"
  virtual_network_name = module.environment.virtual_network_name
  vm_name              = "ubuntu2"
}

module "standalone-chkp" {
  depends_on = [
    module.environment.cp_back_subnet_id,
    module.environment.cp_front_subnet_id
  ]
  sg_name                       = "chkp-standalone"
  source                        = "./03-checkpoint"
  resource_group_name           = module.environment.resource_group_name
  cp_back_subnet_id             = module.environment.cp_back_subnet_id
  cp_front_subnet_id            = module.environment.cp_front_subnet_id
  admin_username                = "guru"
  admin_password                = var.admin_password
  authentication_type           = "Password"
  sic_key                       = "Vpn123456!Vpn123456"
  management_GUI_client_network = "0.0.0.0/0"
  vm_size                       = "Standard_D3_v2"

}

module "aks1" {
  depends_on = [
    module.environment.aks_subnet_id
  ]
  aks_name                       = "aks1"
  source                        = "./04-aks"
  aks_subnet_id = module.environment.aks_subnet_id
  resource_group_name           = module.environment.resource_group_name
}


# module "cp-policy" {
#   source = "./05-policy"
#   cp-management-host = module.standalone-chkp.cp-public-ip
#   cp-management-user = "api_user"
#   cp-management-password = var.cp-management-password
#   publish = var.publish
#   install = var.install
#   install_target = module.standalone-chkp.sg_name
# }