output "publicNetwork" {
  value = "${var.publicNetwork}"
}

output "zone" {
  value = "${var.zone}"
}

output "default_name" {
  value = "${var.name}"
}

output "network" {
  value = "${openstack_networking_network_v2.network.id}"
}

output "network_name" {
  value = "${openstack_networking_network_v2.network.name}"
}

output "router" {
  value = "${openstack_networking_router_interface_v2.router_interface_1.id}"
}

output "subnet" {
  value = "${openstack_networking_subnet_v2.subnet.cidr}"
}

output "subnetid" {
  value = "${openstack_networking_subnet_v2.subnet.id}"
}