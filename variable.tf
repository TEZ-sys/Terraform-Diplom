variable "region" {
  description = "AWS London-Region"
  default     = "eu-west-2"
}

variable "ami" {
  description = "Amazon Machine Image ID for Ubuntu Server 22"
  default     = "ami-0d09654d0a20d3ae2"
}

variable "type" {
  description = "Size of VM"
  default     = "t2.micro"
}

variable "ports" {
  description = "Allow ports"
  type        = list(any)
  default     = ["22", "80", "3000"]
}

variable "CIDR" {
  description = "CIDR for ingress and egress"
  default     = ["0.0.0.0/0"]
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 3
}

variable "desired_capacity" {
  default = 2
}

variable "main_vpc_cidr" {}
variable "public_subnets" {}
variable "private_subnets" {}
