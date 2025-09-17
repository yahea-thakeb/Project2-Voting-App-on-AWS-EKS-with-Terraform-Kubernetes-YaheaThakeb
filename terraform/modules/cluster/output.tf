output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "frontend_node_group_name" {
  value = aws_eks_node_group.frontend_node.node_group_name
}

output "bacend_node_group_name" {
  value = aws_eks_node_group.backend_node.node_group_name
}

output "db_node_group_name" {
  value = aws_eks_node_group.db_node.node_group_name
}