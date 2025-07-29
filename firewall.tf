resource "hcloud_firewall" "cluster_node_firewall" {
  name = "${var.deployment_name}-firewall"

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0"
    ]
  }

  dynamic "rule" {
    for_each = var.wireguard_tunnel_enabled ? [1] : []
    content {
      direction = "in"
      protocol  = "udp"
      port      = "51820"
      source_ips = [
        "0.0.0.0/0"
      ]
    }
  }

  dynamic "rule" {
    for_each = var.public_ssh_enabled ? [1] : []
    content {
      direction = "in"
      protocol  = "tcp"
      port      = "22"
      source_ips = [
        "0.0.0.0/0"
      ]
    }
  }

  dynamic "rule" {
    for_each = var.public_k8s_api_enabled ? [1] : []
    content {
      direction = "in"
      protocol  = "tcp"
      port      = "6443"
      source_ips = [
        "0.0.0.0/0"
      ]
    }
  }
}
