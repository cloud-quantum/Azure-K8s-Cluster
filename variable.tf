variable "name" {
  description = "The name of the AKS cluster."
  type        = string
  default     = "default-aks-name"
}

variable "location" {
  description = "The location/region where the AKS cluster is created."
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "default-resource-group"
}

variable "dns_prefix" {
  description = "DNS prefix specified when creating the managed cluster."
  type        = string
  default     = "default-dns-prefix"
}

variable "kubernetes_version" {
  description = "Version of Kubernetes specified when creating the AKS."
  type        = string
  default     = "1.29"
}

variable "node_resource_group" {
  description = "The name of the resource group where AKS nodes will reside."
  type        = string
  default     = "default-node-resource-group"
}

variable "default_node_pool_count" {
  description = "The number of nodes for the default node pool."
  type        = number
  default     = 1
}

variable "default_node_pool_vm_size" {
  description = "The size of the Virtual Machines to use for nodes."
  type        = string
  default     = "Standard_D2s_v3"
}

variable "default_node_pool_auto_scaling" {
  description = "Whether to enable auto-scaling for the default node pool."
  type        = bool
  default     = true
}

variable "default_node_pool_min_count" {
  description = "Minimum number of nodes for auto-scaling in the default node pool."
  type        = number
  default     = 1
}

variable "default_node_pool_max_count" {
  description = "Maximum number of nodes for auto-scaling in the default node pool."
  type        = number
  default     = 2
}

variable "vnet_subnet_id" {
  description = "The subnet ID to be used for the AKS cluster."
  type        = string
  default     = "default-vnet-subnet-id"
}

variable "network_plugin" {
  description = "Network plugin to use for networking."
  type        = string
  default     = "azure"
}

variable "load_balancer_sku" {
  description = "Specifies the SKU of the Load Balancer used for the AKS."
  type        = string
  default     = "standard"
}

variable "service_cidr" {
  description = "The network range used by the Kubernetes service."
  type        = string
  default     = "10.255.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address within the Kubernetes service address range that will be used by cluster service discovery (DNS)."
  type        = string
  default     = "10.255.0.10"
}

variable "agent_pool_profiles" {
  description = <<-EOT
    List of agent pool profiles for the AKS cluster.
    Supported properties are:
      - name: string
      - count: number
      - vm_size: string
      - os_disk_size_gb: number
      - vnet_subnet_id: string
      - max_pods: number
      - os_type: string
      - enable_auto_scaling: bool
      - min_count: number
      - max_count: number
      - scale_down_mode: string
  EOT
  type = list(object({
    name                = string
    count               = number
    vm_size             = string
    os_disk_size_gb     = number
    vnet_subnet_id      = string
    max_pods            = number
    os_type             = string
    enable_auto_scaling = bool
    min_count           = number
    max_count           = number
    scale_down_mode     = string
  }))
  default = [
    {
      name                = "node-agentpool"
      count               = 1
      vm_size             = "Standard_D2s_v3"
      os_disk_size_gb     = 30
      vnet_subnet_id      = "default-vnet-subnet-id"
      max_pods            = 30
      os_type             = "Linux"
      enable_auto_scaling = true
      min_count           = 1
      max_count           = 2
      scale_down_mode     = "Delete"
    }
  ]
}
