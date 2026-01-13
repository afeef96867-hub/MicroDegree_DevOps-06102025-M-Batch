provider "aws" {
  region = "us-west-2"
}

# create vpc
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "VPC-PRoject"
  }
}

# create subnet -1
resource "aws_subnet" "subnet-1" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

# create subnet -2
resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.myvpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-1"
  }
}

# create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "route-table-custom"
  }
}

# internet gateway
resource "aws_internet_gateway" "myigw" {
  vpc_id = aws_vpc.myvpc.id
  tags = {
    Name = "MyIGW"
  }
}
# creating public route
resource "aws_route" "public_route" {
  route_table_id = aws_route_table.public_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.myigw.id
}


# route associations
resource "aws_route_table_association" "public_subnet_association" {
  route_table_id = aws_route_table.public_route_table.id
  subnet_id = aws_subnet.subnet-1.id 
}