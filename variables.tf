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
  
variable "admin_password" {
  description = "Administrator password of deployed Virtual Macine. The password must meet the complexity requirements of Azure"
  type        = string
}
