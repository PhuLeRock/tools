
output "eks_endpoint" {
    description = "Endpoint for your Kubernetes API server"
    value = aws_eks_cluster.devopsthehardway-eks.endpoint
}
output "export_kube_config_command" {
    description = "export kube config"
    value = "aws eks update-kubeconfig --name ${var.eks_clustername} --region us-west-2 --profile default"
}