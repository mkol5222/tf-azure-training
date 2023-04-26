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

  variable "route_through_firewall" {
    description = "set true if route through firewall is needed"
    type = bool
    default = false
  }

variable "publish" {
  type        = bool
  default     = false
  description = "Set to true to publish changes"
}
  variable "install" {
  type        = bool
  default     = false
  description = "Set to true to INSTALL POLICY"
}



variable "cp-management-user" {
  type        = string
  description = "CHKP Management server username"
}
variable "cp-management-password" {
  type        = string
  description = "CHKP Management server password"
}