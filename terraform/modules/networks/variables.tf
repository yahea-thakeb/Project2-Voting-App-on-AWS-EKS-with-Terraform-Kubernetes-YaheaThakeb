variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "availability_zone" {
  type    = string
  default = "me-central-1"
}

variable "subnet_availability_zone" {
  type    = string
  default = "me-central-1a"
}

variable "secondary_subnet_availability_zone" {
  type    = string
  default = "me-central-1b"
}