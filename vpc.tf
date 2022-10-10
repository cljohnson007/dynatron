data "aws_availability_zones" "available" {}

module "vpc" {
  source                                          = "terraform-aws-modules/vpc/aws"
  name                                            = var.vpc_name
  cidr                                            = var.cidr_block
  azs                                             = data.aws_availability_zones.available.names
  private_subnets                                 = var.private_subnets
  public_subnets                                  = var.public_subnets
  enable_dns_support                              = true
  enable_dns_hostnames                            = true
  enable_nat_gateway                              = true
  single_nat_gateway                              = true
  private_subnet_tags                             = {
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
  public_subnet_tags                              = {
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
  tags                                            = { 
    ENV                                           = var.env
    "kubernetes.io/cluster/${var.cluster_name}"   = "shared"
  }
}