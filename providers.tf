terraform {
  required_version = ">= 1.5.0"
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.62.0"
    }
    wireguard = {
      source  = "OJFord/wireguard"
      version = "~> 0.4.0"
    }
    ct = {
      source  = "poseidon/ct"
      version = "~> 0.14.0"
    }
  }
}
