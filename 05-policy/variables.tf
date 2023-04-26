
variable "cp-management-host" {
  type        = string
  description = "CHKP Management server hostname or IP address"
}

variable "cp-management-user" {
  type        = string
  description = "CHKP Management server username"
}
variable "cp-management-password" {
  type        = string
  description = "CHKP Management server password"
}
variable "cp-management-api-context" {
  type        = string
  description = "CHKP Management server context - defalts to web_api (in management server URL)"
  default     = "web_api"
}

variable "install_target" {
  type        = string
  description = "name of TARGET object for policy installation"
}

variable "package_name" {
  type        = string
  description = "name of package to install"
  default = "TerraformPolicyDemo"
}
  
