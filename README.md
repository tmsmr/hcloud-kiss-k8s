# hcloud-kiss-k8s

*Poor Man's Kubernetes*

Terraform module for deploying a single-node Kubernetes cluster on Hetzner Cloud, focused on maintainability and low
cost.

→ If you need a Kubernetes cluster for business-critical workloads, this is not the right solution.

→ However, if you want an affordable and low-maintenance way to run personal projects on Kubernetes, this might be just
what you need 😀.

## Components

- [Hetzner Cloud VPS](https://www.hetzner.com/cloud): Depending on your needs starting at around 5 €/month.
- [Fedora CoreOS](https://getfedora.org/en/coreos/): Minimal and immutable Linux distribution with nightly updates
  configured.
- [WireGuard](https://www.wireguard.com/): Improved security for SSH and Kubernetes API access.
- [K3s](https://k3s.io/): Lightweight Kubernetes with nightly updates configured.

## Minimal example

1. Use the module in your Terraform configuration

```hcl
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

resource "hcloud_ssh_key" "admin_key" {
  name       = "johndoe"
  public_key = "ssh-rsa xxx"
}

module "k8s_node" {
  source            = "git::https://github.com/tmsmr/hcloud-kiss-k8s.git?ref=v0.2.1"
  hcloud_ssh_key_id = hcloud_ssh_key.admin_key.id
}

resource "local_sensitive_file" "wireguard_conf" {
  filename = "./k8s-node.conf"
  content  = module.k8s_node.wireguard_client_config
}
```

2. Wait for the node to be ready

It will take a while until the installation is completed after the VPS was created.
Take a look at [hcloud-fcos-takeover](https://github.com/tmsmr/hcloud-fcos-takeover)
and [Butane config](./tpl/node.butane) for more details.
Depending on the VPS type this takes around 5 Minutes.
You might want to check the status by looking at the console output and/or the CPU usage of the VPS in the Hetzner Cloud
Console.

3. Connect to the node

```bash
wg-quick up ./k8s-node.conf # or some other client from https://www.wireguard.com/install/
ssh core@10.20.1.1 # yes, this is static
$ kubectl get node # and so on...
```

...or you grab the kubeconfig file from the node (`/etc/rancher/k3s/k3s.yaml`) and change the server address to
`https://10.20.1.1:6443` to reach the Kubernetes API directly.

## Variables/Customization

| Variable Name                 | Type   | Default         | Description                                                          |
|-------------------------------|--------|-----------------|----------------------------------------------------------------------|
| hcloud_ssh_key_id             | string |                 | SSH key ID in Hetzner Cloud project to use for maintenance access    |
| deployment_name               | string | hcloud-kiss-k8s | Name of the deployment                                               |
| deletion_protection_enabled   | bool   | false           | Enable deletion protection for the VPS                               |
| vps_type                      | string | cax11           | Hetzner Cloud VPS flavor                                             |
| hcloud_datacenter             | string | fsn1-dc14       | Hetzner Cloud datacenter name                                        |
| wireguard_tunnel_enabled      | bool   | true            | Enable WireGuard tunnel for additional security                      |
| public_ssh_enabled            | bool   | false           | Enable public SSH access                                             |
| public_k8s_api_enabled        | bool   | false           | Enable public K8s API access                                         |
| k3s_installer_args            | string |                 | Additional arguments for the K3s installer                           |
| maintenance_window_start_k3s  | string | 03:00           | Start time of the maintenance window (HH:MM format) for k3s updates  |
| maintenance_window_end_k3s    | string | 03:30           | End time of the maintenance window (HH:MM format) for k3s updates    |
| maintenance_window_start_node | string | 03:30           | Start time of the maintenance window (HH:MM format) for node updates |
| vps_backups_enabled           | bool   | false           | Enable automatic backups of the VPS                                  |

More docs to come soon™...

Reach out to me if you need help.

## Disclaimer

Check *LICENSE* for details. If this tool eats your dog, it's not my fault.
