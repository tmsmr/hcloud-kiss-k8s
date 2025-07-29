# hcloud-kiss-k8s
Pragmatic Kubernetes on Hetzner VPS

*WiP*

## Quick start
- deploy with
```terraform
terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
    }
  }
}

provider "hcloud" {
  token = "xxx"
}

module "k8s" {
  source = "git::https://github.com/tmsmr/hcloud-kiss-k8s.git?ref=v0.1.0"

  hcloud_ssh_key_name = "johndoe"
}
```
- connect
```bash
sudo wg-quick up wg/hcloud-kiss-k8s.conf
ssh core@10.20.1.1)
```
