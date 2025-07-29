output "node_ip" {
  value = hcloud_server.fcos_node.ipv4_address
}

output "wireguard_client_config" {
  value     = var.wireguard_tunnel_enabled ? data.wireguard_config_document.client[0].conf : ""
  sensitive = true
}
