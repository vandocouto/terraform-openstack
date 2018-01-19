variable "name" {
  default = "tutoriaisgnulinux"
}

variable "subnet" {
  default = "10.0.0.0/24"
}

/*
Subnet_Cut - Example: 10.0.0.0/24 = 10.0.0.
define ip 101 = 10.0.0.101
*/

output "subnet_cut" {
  value = "${replace(var.subnet, "0/24", "")}"
}

variable "gatewayId" {
  default = "4ab8df8e-bb3d-40f8-b817-103557d84639"
}

variable "publicNetwork" {
  default = "public301"
}

variable "zone" {
  default = "br-sp1-a"
}