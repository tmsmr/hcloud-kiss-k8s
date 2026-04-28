data "hcloud_location" "loc" {
  name = var.hcloud_location
}

data "hcloud_ssh_key" "maintenance_key" {
  id = var.hcloud_ssh_key_id
}
