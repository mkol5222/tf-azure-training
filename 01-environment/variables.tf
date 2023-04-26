variable "subscription_id" {
  description = "The Azure subscription ID"
  type        = string
}

variable "tenant_id" {
  description = "The Azure tenant ID"
  type        = string
}

variable "client_id" {
  description = "The Azure SP client ID"
  type        = string
}

variable "client_secret" {
  description = "The Azure SP client secret"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group for network environment"
  type        = string
  default     = "tf-azure-training-rg"
}

variable "resource_group_location" {
  description = "value for the location of the resource group"
  type        = string
  default     = "westeurope"
}
  
  variable "virtual_network_name" {
    description = "value for the name of the virtual network"
    type = string
    default = "tf-azure-training-vnet"
  }

  variable "route_through_firewall" {
    description = "set true if route through firewall is needed"
    type = bool
    default = false
  }