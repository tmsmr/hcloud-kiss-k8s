locals {
  wg_server_ip = cidrhost(var.wireguard_subnet, 1)
  wg_client_ip = cidrhost(var.wireguard_subnet, 2)
}

module "fcos_node_config" {
  source = "git::https://github.com/tmsmr/hcloud-fcos-takeover.git?ref=v0.4.0"
  butane_config = templatefile("${path.module}/tpl/node.butane", {
    maintenance_key                          = data.hcloud_ssh_key.maintenance_key.public_key
    hostname                                 = var.deployment_name
    node_update_daily_start                  = var.maintenance_window_start_node
    k3s_update_daily_start                   = var.maintenance_window_start_k3s
    k3s_update_daily_end                     = var.maintenance_window_end_k3s
    k3s_installer_args                       = var.k3s_installer_args
    node_shutdown_grace_period               = var.node_shutdown_grace_period
    node_shutdown_grace_period_critical_pods = var.node_shutdown_grace_period_critical_pods

    wg_config  = var.wireguard_tunnel_enabled ? indent(10, data.wireguard_config_document.server[0].conf) : ""
    wg_address = var.wireguard_tunnel_enabled ? local.wg_server_ip : ""
  })
}

resource "hcloud_server" "fcos_node" {
  name         = var.deployment_name
  image        = var.bootstrap_image
  server_type  = var.vps_type
  location     = data.hcloud_location.loc.name
  ssh_keys     = [var.hcloud_ssh_key_id]
  firewall_ids = [hcloud_firewall.cluster_node_firewall.id]
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }
  backups            = var.vps_backups_enabled
  user_data          = module.fcos_node_config.user_data
  delete_protection  = var.deletion_protection_enabled
  rebuild_protection = var.deletion_protection_enabled
}
