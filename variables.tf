variable "resource_group_name" {
  description = "Resource Group Name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "aks_cluster_name" {
  description = "AKS Cluster Name"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix"
  type        = string
}

variable "node_count" {
  description = "Number of nodes"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "VM size for nodes"
  type        = string
  default     = "Standard_D2s_v3"
}
