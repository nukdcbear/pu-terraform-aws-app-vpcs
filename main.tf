data "aws_availability_zones" "available_us" {
  provider = aws.aws-west
  state    = "available"
}

module "aws_us_vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.aws_vpc_us_name
  cidr = var.aws_vpc_us_cidr_block

  # azs  = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  azs  = [for zone in data.aws_availability_zones.available_us.names : zone]

  public_subnets = [for num in range(length(data.aws_availability_zones.available_us.names)) : cidrsubnet(var.aws_vpc_us_cidr_block, 5, (num + 1) * 8)]

  private_subnets = [for num in range(length(data.aws_availability_zones.available_us.names)) : cidrsubnet(var.aws_vpc_us_cidr_block, 5, ((num + 1) * 8) + 1)]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.aws_vpc_us_name
  }

  providers = {
    aws = aws.aws-west
  }
}

data "aws_availability_zones" "available_eu" {
  provider =  aws.aws-eu
  state   = "available"
}

module "aws_eu_vpc" {
  source  = "terraform-aws-modules/vpc/aws"

  name = var.aws_vpc_eu_name
  cidr = var.aws_vpc_eu_cidr_block

  # azs  = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  azs  = [for zone in data.aws_availability_zones.available_eu.names : zone]

  public_subnets = [for num in range(length(data.aws_availability_zones.available_eu.names)) : cidrsubnet(var.aws_vpc_eu_cidr_block, 5, (num + 1) * 8)]

  private_subnets = [for num in range(length(data.aws_availability_zones.available_eu.names)) : cidrsubnet(var.aws_vpc_eu_cidr_block, 5, ((num + 1) * 8) + 1)]

  enable_nat_gateway = true
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.aws_vpc_eu_name
  }

  providers = {
    aws = aws.aws-eu
  }
}

