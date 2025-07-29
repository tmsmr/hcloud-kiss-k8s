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

module "k8s" {
  source              = "git::https://github.com/tmsmr/hcloud-kiss-k8s.git?ref=main"
  deployment_name     = "my-k8s"
  hcloud_ssh_key_name = "johndoe"
}

resource "local_sensitive_file" "wg_conf" {
  filename = "./my-k8s.conf"
  content  = module.k8s.wireguard_client_config
}
```
- wait... (5 min?)
- retrieve and adjust kubeconfig
```bash
sudo wg-quick up ./my-k8s.conf
scp core@10.20.1.1:/etc/rancher/k3s/k3s.yaml .
sed -i '' 's/server:.*$/server: https:\/\/10.20.1.1:6443/g' k3s.yaml
```
- interact
```
KUBECONFIG=./k3s.yaml kubectl get node
```
