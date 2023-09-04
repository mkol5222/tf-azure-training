data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

resource "azurerm_kubernetes_cluster" "aks" {
  depends_on = [
    var.aks_subnet_id
  ]
  name                = var.aks_name
  kubernetes_version  = "1.26"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  dns_prefix          = var.aks_name
  node_resource_group = "${var.resource_group_name}-${var.aks_name}-nodes"

  default_node_pool {

    name       = "system"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
    type       = "VirtualMachineScaleSets"
    #availability_zones  = [1, 2, 3]
    enable_auto_scaling = false
    vnet_subnet_id      = var.aks_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    # load_balancer_sku = "Standard"
    network_plugin = "azure" # azure (CNI)

  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to tags, e.g. because a management agent
      # updates these based on some ruleset managed elsewhere.
      tags,
    ]
  }
}

