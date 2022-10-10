resource "aws_eks_fargate_profile" "default" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = "fp-default"
  pod_execution_role_arn = aws_iam_role.pod_execution_role.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = flatten([module.vpc.private_subnets])

  selector {
    namespace = "default"
  }
  selector {
    namespace = "kube-system"
  }

  depends_on        = [module.eks]
}