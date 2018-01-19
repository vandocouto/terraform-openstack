data "terraform_remote_state" "securityGroup" {
  backend = "local"

  config {
    path = "../securityGroup/terraform.tfstate"
  }
}

data "terraform_remote_state" "networkID" {
  backend = "local"

  config {
    path = "../../network/terraform.tfstate"
  }
}

data "terraform_remote_state" "keypair" {
  backend = "local"

  config {
    path = "../../keys/terraform.tfstate"
  }
}

resource "openstack_compute_keypair_v2" "keypair" {
  name = "${data.terraform_remote_state.networkID.default_name}"
  public_key = "${file("../../keys/${data.terraform_remote_state.keypair.keypair}.pem.pub")}"
}

resource "openstack_compute_floatingip_v2" "floatip_1" {
  pool = "${data.terraform_remote_state.networkID.publicNetwork}"
}

/*resource "openstack_networking_network_v2" "interip_1" {
  name = "${data.terraform_remote_state.networkID.network_name}"
  admin_state_up = "true"
}*/

resource "openstack_compute_floatingip_associate_v2" "IPpublic" {
  floating_ip = "${openstack_compute_floatingip_v2.floatip_1.address}"
  instance_id = "${openstack_compute_instance_v2.instance_1.0.id}"
}

resource "openstack_compute_instance_v2" "instance_1" {
  count = "${var.count_inst}"
  name = "${format("${var.name}-%02d", count.index + 1)}"

  image_id = "${var.image_id}"
  flavor_id = "${var.flavor_id}"
  key_pair = "${data.terraform_remote_state.keypair.keypair}"

  security_groups = [
    "${data.terraform_remote_state.securityGroup.name}"]
  network {
    uuid = "${data.terraform_remote_state.networkID.network}"
    fixed_ip_v4 = "${format("${var.network}.10%01d", count.index + 1)}"
  }

  user_data = "${file("script.sh")}"
}

resource "openstack_blockstorage_volume_v2" "volume_1" {
  count = "${var.count_inst}"
  name = "${format("${data.terraform_remote_state.networkID.subnet_cut}-%02d", count.index + 1)}"
  size = "${var.sizest}"
}

resource "openstack_compute_volume_attach_v2" "attachments" {
  count = "${var.count_inst}"
  instance_id = "${element(openstack_compute_instance_v2.instance_1.*.id, count.index)}"
  volume_id = "${element(openstack_blockstorage_volume_v2.volume_1.*.id, count.index)}"
}