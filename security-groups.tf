#SG for Application Load Balancer
resource "aws_security_group" "alb-security-group" {
  name        = "ALB Security Group"
  description = "Enable HTTP/HTTPS access port 80/443 "
  vpc_id      = aws_vpc.vpc.id

  ingress {
      description      = "HTTP Access"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  ingress {
      description      = "HTTPS Access"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      
    }

  tags = {
    Name = "ALB Security Group"
  }
}

#SG for SSH Access
resource "aws_security_group" "ssh-security-group" {
  name        = "SSH Access"
  description = "Enable SSH Access on port 22"
  vpc_id      = aws_vpc.vpc.id

  ingress {
      description      = "SSH Access"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["${var.ssh-location}"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
    }

  tags = {
    Name = "SSH Security Group"
  }
}

#SG for WebServer
resource "aws_security_group" "weserver-security-group" {
  name        = "webserver Security Group"
  description = "Enable HTTP/HTTPS access port 80/443 via ALB and SSH "
  vpc_id      = aws_vpc.vpc.id

  ingress {
      description      = "HTTP Access"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      security_groups =  ["${aws_security_group.alb-security-group.id}"]
    }
  ingress {
      description      = "HTTPS Access"
      from_port        = 443
      to_port          = 443
      protocol         = "tcp"
      security_groups =  ["${aws_security_group.alb-security-group.id}"]
    }
  ingress {
      description      = "SSH Access"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      security_groups =  ["${aws_security_group.ssh-security-group.id}"]
    }
    
  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      
    }

  tags = {
    Name = "Web Server Security Group"
  }
}

#SG for DataBase
resource "aws_security_group" "database-security-group" {
  name        = "Database Security Group"
  description = "ENable Aurora database port 3306"
  vpc_id      = aws_vpc.vpc.id

  ingress {
      description      = "Aurora Access"
      from_port        = 3306
      to_port          = 3306
      protocol         = "tcp"
      security_groups  = ["${aws_security_group.weserver-security-group.id}"]
    }

  egress {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      
    }

  tags = {
    Name = "Database Security Group"
  }
}