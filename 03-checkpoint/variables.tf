variable "sg_name" {
  type        = string
  description = "Check Point SG(standalone) name"
  default     = "chkp"
}

variable "vm_os_sku" {
  /*
    Choose from:
      - "sg-byol"
      - "sg-ngtp-v2" (for R80.30 only)
      - "sg-ngtx-v2" (for R80.30 only)
      - "sg-ngtp" (for R80.40 and above)
      - "sg-ngtx" (for R80.40 and above)
      - "mgmt-byol"
      - "mgmt-25"
  */
  description = "The sku of the image to be deployed"
  type        = string
  default     = "mgmt-byol"
}
variable "vm_os_offer" {
  description = "The name of the image offer to be deployed.Choose from: check-point-cg-r8030, check-point-cg-r8040, check-point-cg-r81"
  type        = string
  default     = "check-point-cg-r8110"
}
variable "publisher" {
  description = "CheckPoint publicher"
  default     = "checkpoint"
}

variable "resource_group_name" {
  description = "Resource Group for network environment"
  type        = string
  default     = "tf-azure-training-rg"
}

variable "admin_username" {
  description = "Administrator username of deployed VM. Due to Azure limitations 'notused' name can be used"
  type        = string
  default     = "admin"
}

variable "admin_password" {
  description = "Administrator password of deployed Virtual Macine. The password must meet the complexity requirements of Azure"
  type        = string
}



variable "vnet_allocation_method" {
  description = "IP address allocation method"
  type        = string
  default     = "Static"
}

variable "cp_front_subnet_id" {
  description = "Subnet ID for Check Point Frontend"
  type        = string
}


variable "cp_back_subnet_id" {
  description = "Subnet ID for Check Point Backend"
  type        = string
}

// bootdiag storage
variable "storage_account_tier" {
  description = "Defines the Tier to use for this storage account.Valid options are Standard and Premium"
  default     = "Standard"
}
variable "account_replication_type" {
  description = "Defines the type of replication to use for this storage account.Valid options are LRS, GRS, RAGRS and ZRS"
  type        = string
  default     = "LRS"
}


// VM
variable "vm_size" {
  description = "Specifies size of Virtual Machine"
  type        = string
  default = "Standard_D3_v2"
}

variable "delete_os_disk_on_termination" {
  type        = bool
  description = "Delete datadisk when VM is terminated"
  default     = true
}

