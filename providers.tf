terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.62.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.4.0"
    }
  }
}
