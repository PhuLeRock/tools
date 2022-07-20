output "eks_endpoint" {
    description = "Endpoint for your Kubernetes API server"
    value = aws_eks_cluster.devopsthehardway-eks.endpoint
}