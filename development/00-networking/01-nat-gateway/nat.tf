resource "aws_eip" "this" {
  domain = "vpc"

  tags = {
    Name = "${local.name_prefix}-nat-eip"
  }
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.this.id
  subnet_id     = data.terraform_remote_state.vpc_core.outputs.public_subnet_a_id

  tags = {
    Name = "${local.name_prefix}-nat-gw"
  }
}

resource "aws_route" "private_internet" {
  for_each = data.terraform_remote_state.vpc_core.outputs.private_route_table_ids

  route_table_id         = each.value
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this.id
}
