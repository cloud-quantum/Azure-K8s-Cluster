output "cluster_id" {
  value       = azurerm_kubernetes_cluster.aks.id
  description = "The ID of the AKS cluster."
}

output "cluster_node_resource_group" {
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
  description = "The name of the resource group containing the AKS cluster nodes."
}
