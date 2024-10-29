resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "default"
    node_count          = var.default_node_pool_count
    vm_size             = var.default_node_pool_vm_size
    enable_auto_scaling = var.default_node_pool_auto_scaling
    min_count           = var.default_node_pool_min_count
    max_count           = var.default_node_pool_max_count
    vnet_subnet_id      = var.vnet_subnet_id
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin     = var.network_plugin
    load_balancer_sku  = var.load_balancer_sku
    service_cidr       = var.service_cidr
    dns_service_ip     = var.dns_service_ip  
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "node_pools" {
  for_each              = { for idx, pool in var.agent_pool_profiles : idx => pool }
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  name                  = each.value.name
  node_count            = each.value.count
  vm_size               = each.value.vm_size
  vnet_subnet_id        = each.value.vnet_subnet_id
  max_pods              = each.value.max_pods
  os_type               = each.value.os_type
  enable_auto_scaling   = each.value.enable_auto_scaling
  min_count             = each.value.min_count
  max_count             = each.value.max_count
  os_disk_size_gb       = each.value.os_disk_size_gb
}
