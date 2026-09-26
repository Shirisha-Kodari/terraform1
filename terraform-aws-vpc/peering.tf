resource "aws_vpc_peering_connection" "default" {
  count = var.is_peering_required ? 1 : 0 #1-->peering =true or 0-->false 

  peer_vpc_id   = data.aws_vpc.default.id #this is accepter vpc which is default here this deafult vpc existing vpc 
  vpc_id        = aws_vpc.main.id # requester vpc created through terraform 

  accepter { # inside requester we enable dns resolution 
    allow_remote_vpc_dns_resolution = true
  }

  requester { #inside requester we enble vpc remote dns resolution 
    allow_remote_vpc_dns_resolution = true
  }
  auto_accept = true # after created peering other owner acce[ter should accespt if we can use same account so we can auto accept and diffrente used not working 

tags = merge (
    var.vpc_peering_tags,
    local.common_tags,{
     Name = "${var.project}-${var.environment}-default"   
    }

)
}

resource "aws_route" "public_peering" {
 count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "private_peering" { 
 count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

resource "aws_route" "database_peering" {
 count = var.is_peering_required ? 1 : 0
  route_table_id            = aws_route_table.database.id   
  destination_cidr_block    = data.aws_vpc.default.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}

# we should add peering connection in default vpc main route table
resource "aws_route" "default_peering" {
 count = var.is_peering_required ? 1 : 0
  route_table_id            = data.aws_route_table.main.id
  destination_cidr_block    = var.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.default[count.index].id
}   