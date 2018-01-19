variable "name" {
  description = "name displays instances"
  default = "docker"
}

variable "image_id" {
  description = "ID image OpenStack"
  default = "33a3995d-c9a5-45de-ab78-a27cccebd9fd"
}

variable "flavor_id" {
  description = "ID flavor OpenStack"
  default = "17f87c39-9a3d-4df3-a9b8-a6137a3438e8"
}

variable "sizest" {
  default = "10"
}

variable "count_inst" {
  description = "number de instances"
  default = "3"
}

variable "network" {
  description = "adjust networking accordingly variables network"
  default = "10.0.0"
}