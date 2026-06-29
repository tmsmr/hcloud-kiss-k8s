terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.66"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.4.0"
    }
  }
}
