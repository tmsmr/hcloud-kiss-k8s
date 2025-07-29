locals {
  wg_server_port = 51820
}

resource "wireguard_asymmetric_key" "server_keypair" {
  count = var.wireguard_tunnel_enabled ? 1 : 0
}

resource "wireguard_asymmetric_key" "client_keypair" {
  count = var.wireguard_tunnel_enabled ? 1 : 0
}

resource "wireguard_preshared_key" "client_psk" {
  count = var.wireguard_tunnel_enabled ? 1 : 0
}

data "wireguard_config_document" "server" {
  count = var.wireguard_tunnel_enabled ? 1 : 0

  addresses = [local.wg_server_ip]
  private_key = wireguard_asymmetric_key.server_keypair[0].private_key
  listen_port = local.wg_server_port
  peer {
    allowed_ips = [local.wg_client_ip]
    public_key    = wireguard_asymmetric_key.client_keypair[0].public_key
    preshared_key = wireguard_preshared_key.client_psk[0].key
  }
}

data "wireguard_config_document" "client" {
  count = var.wireguard_tunnel_enabled ? 1 : 0

  addresses = [local.wg_client_ip]
  private_key = wireguard_asymmetric_key.client_keypair[0].private_key
  peer {
    endpoint      = "${hcloud_server.fcos_node.ipv4_address}:${local.wg_server_port}"
    allowed_ips = [local.wg_server_ip]
    public_key    = wireguard_asymmetric_key.server_keypair[0].public_key
    preshared_key = wireguard_preshared_key.client_psk[0].key
  }
}
