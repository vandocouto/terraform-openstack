/*output "InstanceIP" {
  value = "${openstack_compute_instance_v2.instance_1.network.fixed_ip_v4}"
}*/

output "privateIP1" {
  value = "${join(",", openstack_compute_instance_v2.instance_1.*.access_ip_v4)}"
}

output "privateIP2" {
  value = "${openstack_compute_instance_v2.instance_1.*.access_ip_v4}"
}

output "privateIP3" {
  value = "${openstack_compute_instance_v2.instance_1.*.network.0.fixed_ip_v4}"
}

output "floatingIP" {
  value = "${openstack_compute_floatingip_v2.floatip_1.address}"
}

output "count_inst" {
  value = "${openstack_compute_instance_v2.instance_1.count}"
}