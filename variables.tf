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
  default     = "cx23"
}

variable "hcloud_location" {
  description = "Hetzner Cloud location name"
  type        = string
  default     = "nbg1"
}

variable "wireguard_tunnel_enabled" {
  description = "Enable WireGuard tunnel for additional security"
  type        = bool
  default     = true
}

variable "wireguard_subnet" {
  description = "Subnet for the VPN configuration"
  type        = string
  default     = "10.20.1.0/24"
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

  validation {
    condition     = can(regex("^([01][0-9]|2[0-3]):[0-5][0-9]$", var.maintenance_window_start_k3s))
    error_message = "HH:MM format required"
  }
}

variable "maintenance_window_end_k3s" {
  description = "End time of the maintenance window (HH:MM format) for k3s updates"
  type        = string
  default     = "03:30"

  validation {
    condition     = can(regex("^([01][0-9]|2[0-3]):[0-5][0-9]$", var.maintenance_window_end_k3s))
    error_message = "HH:MM format required"
  }
}

variable "maintenance_window_start_node" {
  description = "Start time of the maintenance window (HH:MM format) for node updates"
  type        = string
  default     = "03:30"

  validation {
    condition     = can(regex("^([01][0-9]|2[0-3]):[0-5][0-9]$", var.maintenance_window_start_node))
    error_message = "HH:MM format required"
  }
}

variable "public_ssh_allowed_cidrs" {
  description = "CIDR blocks allowed for public SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "public_k8s_api_allowed_cidrs" {
  description = "CIDR blocks allowed for public K8s API access"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "vps_backups_enabled" {
  description = "Enable automatic backups for the VPS"
  type        = bool
  default     = false
}

variable "bootstrap_image" {
  description = "Fedora image name for Hetzner Cloud bootstrap (must be compatible with hcloud-fcos-takeover)"
  type        = string
  default     = "fedora-43"
}

variable "node_shutdown_grace_period" {
  description = "Total grace period for pod eviction during node shutdown"
  type        = string
  default     = "90s"
}

variable "node_shutdown_grace_period_critical_pods" {
  description = "Grace period reserved for critical pods during node shutdown"
  type        = string
  default     = "20s"
}
