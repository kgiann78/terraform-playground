# Configuration for the Development System's infrastructure VPC configuration.
# Essentially in this file we are restricting inbound traffic to the
# corresponding EC2 instance only via SSH, HTTP and HTTPS.

resource "aws_vpc" "development_system_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = local.tags
}

resource "aws_subnet" "development_system_subnet" {
  cidr_block        = cidrsubnet(aws_vpc.development_system_vpc.cidr_block, 3, 1)
  vpc_id            = aws_vpc.development_system_vpc.id
}

resource "aws_security_group" "development_system_allow_ssh" {
  vpc_id      = aws_vpc.development_system_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_security_group" "development_system_allow_http" {
  vpc_id      = aws_vpc.development_system_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}

resource "aws_security_group" "development_system_allow_https" {
  vpc_id      = aws_vpc.development_system_vpc.id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = local.tags
}
