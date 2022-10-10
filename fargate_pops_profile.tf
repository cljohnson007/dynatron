resource "aws_eks_fargate_profile" "dynatron" {
  cluster_name           = var.cluster_name
  fargate_profile_name   = "fp_dynatron"
  pod_execution_role_arn = aws_iam_role.pod_execution_role.arn

  # These subnets must have the following resource tag: 
  # kubernetes.io/cluster/<CLUSTER_NAME>.
  subnet_ids = flatten([module.vpc.private_subnets])

  selector {
    namespace = "dynatron"
  }
  

  depends_on        = [module.eks]
}