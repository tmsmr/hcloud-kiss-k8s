locals {
  bootstrap_image = "fedora-42"
  wg_subnet       = "10.20.1.0/24"
  wg_server_ip    = cidrhost(local.wg_subnet, 1)
  wg_client_ip    = cidrhost(local.wg_subnet, 2)
}
