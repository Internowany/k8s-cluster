resource "aws_vpc" "SK_vpc" {
  cidr_block           = var.VPC_CIDR
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "SK_vpc-name"
  }
}

resource "aws_subnet" "SK_subnets" {
  for_each                = var.PUBLIC_SUBNETS
  vpc_id                  = aws_vpc.SK_vpc.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name = "SK_subnets_${each.value.cidr}-name"
    "kubernetes.io/role/elb"     = "1"
  }
}

resource "aws_internet_gateway" "SK_igw" {
  vpc_id = aws_vpc.SK_vpc.id

  tags = {
    Name = "SK_igw-name"
  }
}

resource "aws_route_table" "SK_public_route_table" {
  vpc_id = aws_vpc.SK_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.SK_igw.id
  }

  tags = {
    Name = "SK_public_route_table-name"
  }
}

resource "aws_route_table_association" "SK_public_association" {
  for_each       = var.PUBLIC_SUBNETS
  subnet_id      = aws_subnet.SK_subnets[each.key].id
  route_table_id = aws_route_table.SK_public_route_table.id
}

resource "aws_security_group" "SK_sg" {
  vpc_id = aws_vpc.SK_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SK_sg-name"
  }
}
