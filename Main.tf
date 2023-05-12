terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.5.0"
    }
  }
}
#-----------------------------------provider_"aws" ------------------------------
provider "aws" {
  region  = var.region[0]
  profile = "Terraform-Windows-Diplom"
}

provider "aws" {
  region  = var.region[1]
  profile = "Terraform-Windows-Diplom"
  alias   = "reg_FF"
}