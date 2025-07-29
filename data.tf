data "hcloud_datacenter" "dc" {
  name = var.hcloud_datacenter
}

data "hcloud_ssh_key" "maintenance_key" {
  name = var.hcloud_ssh_key_name
}
