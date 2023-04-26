resource "checkpoint_management_network" "net-linux" {
  name         = "net-linux"
  subnet4      = "10.42.5.0"
  mask_length4 = 24
  #color = "green"
  ignore_warnings = true
  nat_settings = {
    auto_rule = true
  }
}

resource "checkpoint_management_network" "net-aks1" {
  name         = "net-aks1"
  subnet4      = "10.42.1.0"
  mask_length4 = 24
  #color = "green"
  ignore_warnings = true
  nat_settings = {
    auto_rule = true
  }
}