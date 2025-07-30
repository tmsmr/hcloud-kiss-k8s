# hcloud-kiss-k8s
Pragmatic Kubernetes on Hetzner VPS

*WiP*

## Quick start
- deploy with
```terraform
terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
  }
}

provider "hcloud" {
  token = "xxx"
}

resource "hcloud_ssh_key" "client_key" {
  name       = "johndoe"
  public_key = "ssh-rsa xxx"
}

module "hcloud-kiss-k8s" {
  source            = "git::https://github.com/tmsmr/hcloud-kiss-k8s.git?ref=v0.2.0"
  hcloud_ssh_key_id = hcloud_ssh_key.client_key.id
}

resource "local_sensitive_file" "wg_conf" {
  filename = "./hcloud-kiss-k8s-tunnel.conf"
  content  = module.hcloud-kiss-k8s.wireguard_client_config
}
```
- wait... (5 min?)
- connect and play
```bash
sudo wg-quick up ./hcloud-kiss-k8s-tunnel.conf
ssh core@10.20.1.1
kubectl get node
```
