resource "aws_eip" "development_system_swarm_manager_eip" {
  instance = aws_instance.development_system_swarm_manager.id
  vpc      = true
  tags     = local.tags
}

resource "aws_internet_gateway" "development_system_gw" {
  vpc_id = aws_vpc.development_system_vpc.id
  tags   = local.tags
}

resource "aws_route_table" "development_system_rt" {
  vpc_id = aws_vpc.development_system_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.development_system_gw.id
  }
  tags = local.tags
}

resource "aws_route_table_association" "development_system_rta" {
  subnet_id      = aws_subnet.development_system_subnet.id
  route_table_id = aws_route_table.development_system_rt.id
}
