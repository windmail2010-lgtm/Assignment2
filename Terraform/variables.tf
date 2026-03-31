variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "my_ip" {
  description = "Your public IP (x.x.x.x/32) for SSH access"
  type        = string
}

variable "app_port" {
  description = "Port for the Node.js application"
  type        = number
  default     = 3000
}

variable "student_name" {
  type = string
}

variable "student_id" {
  type = string
}

variable "course_name" {
  type    = string
  default = "Cloud Infrastructure"
}