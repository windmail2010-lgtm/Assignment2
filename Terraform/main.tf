provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "app_sg" {
  name        = "node-app-sg"
  description = "Allow SSH and App Port"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip]
  }

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "app_server" {
  ami                    = "ami-0c101f26f147fa7fd" # Amazon Linux 2023
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.app_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Update and install Node.js and Git [cite: 42, 44]
              dnf update -y
              dnf install -y nodejs git

              # Setup application directory
              mkdir -p /home/ec2-user/app
              cd /home/ec2-user/app

              # Initialize and install Express
              npm init -y
              npm install express

              # Create the API script [cite: 48-54]
              cat <<JS > index.js
              const express = require('express');
              const app = express();
              const port = ${var.app_port};

              app.get('/', (req, res) => {
                res.send('Hello from Assignment 2');
              });

              app.get('/info', (req, res) => {
                res.json({
                  name: "${var.student_name}",
                  student_id: "${var.student_id}",
                  course: "${var.course_name}"
                });
              });

              app.listen(port, () => {
                console.log('App running on port ' + port);
              });
              JS

              # Run the application automatically [cite: 57-58]
              nohup node index.js > app.log 2>&1 &
              EOF

  tags = {
    Name = "NodeJS-Backend-Assignment"
  }
}