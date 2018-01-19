variable "name" {
  default = "LB-WEB"
}

resource "openstack_networking_secgroup_v2" "securityGroup" {
  name = "${var.name}"
  description = "${var.name}"
}

resource "openstack_networking_secgroup_rule_v2" "port80" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 80
  port_range_max = 80
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.securityGroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "port443" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 443
  port_range_max = 443
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.securityGroup.id}"
}

resource "openstack_networking_secgroup_rule_v2" "icmp" {
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.securityGroup.id}"
}



