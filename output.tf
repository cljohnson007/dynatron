data "aws_subnets" "private" {
  filter{
    name = "tag:Name"
    values = ["dynatron-vpc-private*"]
  }

}
data "aws_subnets" "public" {
  filter{
    name = "tag:Name"
    values = ["dynatron-vpc-public*"]
  }

}

output "vpc_id" {
  description                   = "The ID of the VPC"
  value                         = module.vpc.vpc_id
}
output "private_subnets" {
  description                   = "Private Subnet IDs"
  value                         = data.aws_subnets.private.ids
}
output "public_subnets" {
  description                   = "Public Subnet IDs"
  value                         = data.aws_subnets.public.ids
}

