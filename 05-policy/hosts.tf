resource "checkpoint_management_host" "orange_host" {
  name = "BlueHost"
  ipv4_address = "192.177.2.1"
  color = "blue"
  tags = ["madeByTerraform"]
}

# resource "checkpoint_management_host" "hello_host" {
# }