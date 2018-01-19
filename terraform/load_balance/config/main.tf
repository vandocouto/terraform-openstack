variable "name" {
  description = "Name Load Balance"
  default = "LB-DOCKER-TRAEFIK"
}

data "terraform_remote_state" "networkId" {
  backend = "local"

  config {
    path = "../../network/terraform.tfstate"
  }
}

data "terraform_remote_state" "compute" {
  backend = "local"

  config {
    path = "../../docker/ec2/terraform.tfstate"
  }
}

data "terraform_remote_state" "securityGroup" {
  backend = "local"

  config {
    path = "../securityGroup/terraform.tfstate"
  }
}

resource "openstack_lb_loadbalancer_v2" "loadbalance" {
  name = "${var.name}"
  vip_subnet_id = "${data.terraform_remote_state.networkId.subnetid}"
  security_group_ids = ["${data.terraform_remote_state.securityGroup.sgID}"]
}

resource "openstack_networking_floatingip_v2" "floatingIP_lb" {
  pool = "${data.terraform_remote_state.networkId.publicNetwork}"
  port_id = "${openstack_lb_loadbalancer_v2.loadbalance.vip_port_id}"
}

resource "openstack_lb_listener_v2" "lb_listener" {
  name = "${var.name}"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.loadbalance.id}"
  protocol = "TCP"
  protocol_port = 80
  admin_state_up = "true"
}

resource "openstack_lb_pool_v2" "lb_pool" {
  name = "${var.name}"
  protocol = "TCP"
  lb_method = "ROUND_ROBIN"
  listener_id = "${openstack_lb_listener_v2.lb_listener.id}"
}

resource "openstack_lb_monitor_v2" "lb_monitor" {
  name = "${var.name}"
  delay = 2
  max_retries = 3
  pool_id = "${openstack_lb_pool_v2.lb_pool.id}"
  timeout = 5
  type = "TCP"
}

resource "openstack_lb_member_v2" "lb_members" {
  name = "${var.name}"
  count = "${data.terraform_remote_state.compute.count_inst}"
  pool_id = "${openstack_lb_pool_v2.lb_pool.id}"
  subnet_id = "${data.terraform_remote_state.networkId.subnetid}"
  address = "${element(split(",",data.terraform_remote_state.compute.privateIP1), count.index )}"
  protocol_port = 80
}

resource "openstack_networking_port_v2" "lb_port" {
  name = "${var.name}"
  network_id = "${data.terraform_remote_state.networkId.network}"
  security_group_ids = [
    "${data.terraform_remote_state.securityGroup.sgID}"
  ]
  admin_state_up = "true"
}

