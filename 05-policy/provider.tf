provider "checkpoint" {
  # Configuration options
  server   = var.cp-management-host
  username = var.cp-management-user
  password = var.cp-management-password
  context  = var.cp-management-api-context
}

terraform {
  required_providers {

     checkpoint = {
      source = "CheckPointSW/checkpoint"
      version = "2.3.0"
      #version = "2.2.0"
    }
  }
}