variable "aks_name" {
  type        = string
  description = "AKS cluster name"
  default     = "aks"
}

variable "aks_subnet_id" {
    type        = string
    description = "Subnet ID for AKS"
}

variable "resource_group_name" {
  description = "Resource Group for network environment"
  type        = string
  default     = "tf-azure-training-rg"
}