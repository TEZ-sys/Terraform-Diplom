variable "region" {
  description = "AWS London-Region and Frankfurt-Region "
  type        = list(any)
  default     = ["eu-west-2", "eu-central-1"]
}

variable "ami" {
  description = "Amazon Machine Image ID for Ubuntu Server 22"
  default     = ""
}

variable "type" {
  description = "Size of VM"
  default     = "t2.micro"
}

variable "ports" {
  description = "Allow ports"
  type        = list(any)
  default     = ["22", "80", "443"]
}

variable "CIDR" {
  description = "CIDR for ingress and egress"
  default     = ["0.0.0.0/0"]
}

variable "min_size" {
  default = 2
}

variable "max_size" {
  default = 4
}

variable "zone" {
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c", ]

}

variable "zone2" {
  default = ["eu-central-1a", "eu-central-1b", "eu-central-1c", ]

}

variable "compare" {
  default = "GreaterThanThreshold"
}

variable "thread" {
  default = "70"
}

variable "main_vpc_cidr" {}
variable "private_subnets" {}

variable "public_subnets" {}
variable "public_subnets2" {}
variable "public_subnets3" {}

variable "main_vpc_cidr2" {}
variable "private_subnets2" {}

variable "public_subnets4" {}
variable "public_subnets5" {}
variable "public_subnets6" {}