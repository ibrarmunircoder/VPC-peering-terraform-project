variable "azs" {
  type        = list(string)
  description = "Subnets availability zones"
}

variable "app_subnets" {
  type        = list(string)
  description = "Application subnet cird blocks"
  default     = []
}

variable "public_subnets" {
  type        = list(string)
  description = "Public subnet cird blocks"
  default     = []
}


variable "region" {
  type        = string
  description = "Vpc Region"
  default     = "us-east-1"
}

variable "name" {
  type        = string
  description = "Name of the vpc"
}

variable "cidr" {
  type        = string
  description = "Vpc Cird Block"
}

variable "create_igw" {
  type        = bool
  description = "Allow public access to and from"
  default     = false
}
