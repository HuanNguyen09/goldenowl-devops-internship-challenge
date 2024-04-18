resource "aws_security_group" "public_sg" {
  name        = "public-sg"
  description = "Security group for public access"
  vpc_id      = var.vpc_id
  # Cho phép lưu lượng HTTP và HTTPS từ mọi nguồn
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

  # Cho phép all traffic đi ra từ nhóm bảo mật riêng tư
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Tất cả các protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public-sg"
  }
}

# Tạo nhóm bảo mật riêng tư
resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private access"
  vpc_id      = var.vpc_id
    

  # Cho phép mọi lưu lượng từ nhóm bảo mật công cộng
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"  # Tất cả các protocol
    security_groups = [aws_security_group.public_sg.id]
  }

  # Không cho phép bất kỳ lưu lượng đi ra
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Tất cả các protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private-sg"
  }
}
