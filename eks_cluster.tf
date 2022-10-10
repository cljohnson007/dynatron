module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.29.0"
  cluster_name                                      = var.cluster_name
  subnet_ids                                        = flatten([module.vpc.private_subnets, module.vpc.public_subnets])
  #cluster_timeouts                                   = "30"
  iam_role_name                                     = "EKS-CLUSTER-IAM-ROLE"
  iam_role_use_name_prefix                          = "false"
  cluster_enabled_log_types                         = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
  cloudwatch_log_group_retention_in_days            = 7
  
  vpc_id                                            = module.vpc.vpc_id
  aws_auth_fargate_profile_pod_execution_role_arns  = [aws_iam_role.pod_execution_role.arn]
}
