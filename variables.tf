variable "hcloud_token" {
  description = "Hetzner Cloud API token"
  type        = string
}

variable "hcloud_ssh_key_name" {
  description = "Name of the SSH key in Hetzner Cloud project to use for maintenance access"
  type        = string
}

variable "deployment_name" {
  description = "Name of the deployment"
  type        = string
  default     = "hcloud-kiss-k8s"
}

variable "deletion_protection_enabled" {
  description = "Enable deletion protection for the VPS"
  type        = bool
  default     = false
}

variable "vps_type" {
  description = "Hetzner Cloud VPS flavor"
  type        = string
  default     = "cax11"
}

variable "hcloud_datacenter" {
  description = "Hetzner Cloud datacenter name"
  type        = string
  default     = "fsn1-dc14"
}

variable "wireguard_tunnel_enabled" {
  description = "Enable WireGuard tunnel for additional security"
  type        = bool
  default     = true
}

variable "public_ssh_enabled" {
  description = "Enable public SSH access"
  type        = bool
  default     = false
}

variable "public_k8s_api_enabled" {
  description = "Enable public K8s API access"
  type        = bool
  default     = false
}

variable "maintenance_window_start" {
  description = "Start time of the maintenance window (HH:MM format)"
  type        = string
  default     = "03:00"
}
