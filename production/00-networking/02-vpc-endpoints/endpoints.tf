resource "aws_vpc_endpoint" "s3" {
  vpc_id            = data.terraform_remote_state.vpc_core.outputs.vpc_id
  service_name      = "com.amazonaws.${var.aws_region}.s3"
  vpc_endpoint_type = "Gateway"

  route_table_ids = concat(
    [data.terraform_remote_state.vpc_core.outputs.public_route_table_id],
    values(data.terraform_remote_state.vpc_core.outputs.private_route_table_ids),
    values(data.terraform_remote_state.vpc_core.outputs.db_route_table_ids),
  )

  tags = {
    Name = "${local.name_prefix}-vpce-s3"
  }
}
