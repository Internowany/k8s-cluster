variable "REGION" {
  description = "Frankfurt region"
  type        = string
  default     = "eu-central-1"
}
variable "VPC_CIDR" {
  type    = string
  default = "10.199.0.0/16"
}
variable "PUBLIC_SUBNETS" {
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    "a" = {
      cidr = "10.199.0.0/24"
      az   = "eu-central-1a"
    },
    "b" = {
      cidr = "10.199.1.0/24"
      az   = "eu-central-1b"
    }
    "c" = {
      cidr = "10.199.2.0/24"
      az   = "eu-central-1c"
    }
    "d" = {
      cidr = "10.199.10.0/24"
      az   = "eu-central-1a"
    },
    "e" = {
      cidr = "10.199.11.0/24"
      az   = "eu-central-1b"
    }
    "f" = {
      cidr = "10.199.12.0/24"
      az   = "eu-central-1c"
    }
  }
}
variable "VPC_ID" {
  type    = string
  default = ""
}
variable "Subnet_IDs" {
  type    = list(string)
  default = [""]
}
variable "control_Subnet_IDs" {
  type    = list(string)
  default = [""]
}
