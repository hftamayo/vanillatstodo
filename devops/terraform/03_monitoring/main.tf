# Reference existing EKS cluster
data "aws_eks_cluster" "main" {
  name = var.cluster_name
}

# CloudWatch Log Group for EKS
resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = var.log_retention_days

  tags = {
    Name        = "${var.environment}-${var.cluster_name}-logs"
    Environment = var.environment
    ManagedBy   = "terraform"
  }

  # Prevent recreation of existing log group
  lifecycle {
    prevent_destroy = true
  }  
}