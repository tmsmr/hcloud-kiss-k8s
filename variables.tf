variable "hcloud_ssh_key_id" {
  description = "SSH key ID in Hetzner Cloud project to use for maintenance access"
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

variable "k3s_installer_args" {
  description = "Additional arguments for the K3s installer"
  type        = string
  default     = ""
}

variable "maintenance_window_start_k3s" {
  description = "Start time of the maintenance window (HH:MM format) for k3s updates"
  type        = string
  default     = "03:00"
}

variable "maintenance_window_end_k3s" {
  description = "End time of the maintenance window (HH:MM format) for k3s updates"
  type        = string
  default     = "03:30"
}

variable "maintenance_window_start_node" {
  description = "Start time of the maintenance window (HH:MM format) for node updates"
  type        = string
  default     = "03:30"
}

variable "vps_backups_enabled" {
  description = "Enable automatic backups for the VPS"
  type        = bool
  default     = false
}
