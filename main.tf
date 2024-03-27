resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "sa-east-1c"

  tags = {
    Name = "public_subnet"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "insternet_gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "public_rt"
  }
}

resource "aws_route" "route" {
  route_table_id         = aws_route_table.route_table.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

resource "aws_route_table_association" "rt_assoc" {
  route_table_id = aws_route_table.route_table.id
  subnet_id      = aws_subnet.public_subnet.id
}

resource "aws_security_group" "sec_group" {
  name   = "sec_group"
  vpc_id = aws_vpc.vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  description       = "alow ssh connection"
  security_group_id = aws_security_group.sec_group.id
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  description       = "alow https connection"
  security_group_id = aws_security_group.sec_group.id
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  description       = "alow http connection"
  security_group_id = aws_security_group.sec_group.id
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
  cidr_ipv4         = "0.0.0.0/0"
}
resource "aws_vpc_security_group_egress_rule" "allow_egress" {
  description       = "alow all egress"
  security_group_id = aws_security_group.sec_group.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
}

resource "aws_key_pair" "instance_key" {
  key_name   = "dev-env-key"
  public_key = file("~/.ssh/dev-env-key.pub")
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "t2micro" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = aws_key_pair.instance_key.key_name
  instance_type          = "t2.micro"
  availability_zone      = "sa-east-1c"
  vpc_security_group_ids = [aws_security_group.sec_group.id]
  subnet_id              = aws_subnet.public_subnet.id
  count                  = var.instance_num

  tags = {
    Name = "instance-${count.index + 1}"
  }
}