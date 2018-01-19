resource "openstack_networking_network_v2" "network" {
  name = "${var.name}"
  admin_state_up = "true"
  region = ""
}

resource "openstack_networking_subnet_v2" "subnet" {
  network_id = "${openstack_networking_network_v2.network.id}"
  cidr = "${var.subnet}"
  ip_version = 4
  dns_nameservers = [
    "208.67.220.220",
    "8.8.4.4"]
}

resource "openstack_networking_router_v2" "router" {
  name = "router-${var.name}"
  external_gateway = "${var.gatewayId}"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet.id}"
}
