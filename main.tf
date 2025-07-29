module "fcos_node_config" {
  source = "git::https://github.com/tmsmr/hcloud-fcos-takeover.git?ref=v0.3.0"
  butane_config = templatefile("${path.module}/tpl/node.butane", {
    maintance_key      = data.hcloud_ssh_key.maintenance_key.public_key
    hostname           = var.deployment_name
    update_daily_start = var.maintenance_window_start
    wg_config          = var.wireguard_tunnel_enabled ? indent(10, data.wireguard_config_document.server[0].conf) : ""
    wg_address         = var.wireguard_tunnel_enabled ? local.wg_server_ip : ""
  })
}

resource "hcloud_server" "fcos_node" {
  name        = var.deployment_name
  image       = local.bootstrap_image
  server_type = var.vps_type
  datacenter  = data.hcloud_datacenter.dc.name
  ssh_keys = [data.hcloud_ssh_key.maintenance_key.id]
  firewall_ids = [hcloud_firewall.cluster_node_firewall.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  user_data          = module.fcos_node_config.user_data
  delete_protection  = var.deletion_protection_enabled
  rebuild_protection = var.deletion_protection_enabled
}
