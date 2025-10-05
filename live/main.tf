# Create VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "${var.env}-vpc" }
}

# Create subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "${var.env}-subnet" }
}

# Security group (SSH access)
resource "aws_security_group" "ssh" {
  name   = "${var.env}-ssh"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.env}-sg" }
}

# EC2 instance
resource "aws_instance" "web" {
  ami                    = "ami-0dee22c13ea7a9a67" # Ubuntu 22.04 in ap-south-1
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.ssh.id]
  key_name               = var.key_name
  tags = { Name = "${var.env}-web" }
}
