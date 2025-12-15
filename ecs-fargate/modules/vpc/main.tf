#################################
# VPC
#################################
resource "aws_vpc" "this" {
  cidr_block = var.cidr

  tags = merge(var.tags, {
    Name = "${var.name}-vpc"
  })
}

#################################
# INTERNET GATEWAY
#################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
}

#################################
# PUBLIC SUBNETS (FIXED for_each)
#################################
resource "aws_subnet" "public" {
  for_each = { for idx, cidr in var.public_subnets : idx => cidr }

  vpc_id     = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = true
  availability_zone = lookup(var.azs_map, tostring(each.key))

  tags = {
    Name = "${var.name}-public-${each.key}"
  }
}

#################################
# PRIVATE SUBNETS (FIXED for_each)
#################################
resource "aws_subnet" "private" {
  for_each = { for idx, cidr in var.private_subnets : idx => cidr }

  vpc_id     = aws_vpc.this.id
  cidr_block = each.value
  map_public_ip_on_launch = false
  availability_zone = lookup(var.azs_map, tostring(each.key))

  tags = {
    Name = "${var.name}-private-${each.key}"
  }
}

#################################
# NAT GATEWAY + EIP (FIXED)
#################################
resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_internet_gateway.igw]
}

#################################
# PUBLIC ROUTE TABLE
#################################
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

#################################
# PRIVATE ROUTE TABLE
#################################
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route" "private_default" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat.id
}

resource "aws_route_table_association" "private_assoc" {
  for_each       = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

