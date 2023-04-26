module "environment" {
  source          = "./01-environment"
  client_secret   = var.client_secret
  client_id       = var.client_id
  tenant_id       = var.tenant_id
  subscription_id = var.subscription_id
}

module "ubuntu1" {
    depends_on = [
    module.environment.linux-subnet-id
  ]
    source          = "./02-linux-vm"
    client_secret   = var.client_secret
    client_id       = var.client_id
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
    resource_group_name = module.environment.resource_group_name
    linux-subnet-name = "linux-subnet"
    virtual_network_name = module.environment.virtual_network_name
    vm_name = "ubuntu1"
}

module "ubuntu2" {
  depends_on = [
    module.environment.linux-subnet-id
  ]
    source          = "./02-linux-vm"
    client_secret   = var.client_secret
    client_id       = var.client_id
    tenant_id       = var.tenant_id
    subscription_id = var.subscription_id
    resource_group_name = module.environment.resource_group_name
    linux-subnet-name = "linux-subnet"
    virtual_network_name = module.environment.virtual_network_name
    vm_name = "ubuntu2"
}