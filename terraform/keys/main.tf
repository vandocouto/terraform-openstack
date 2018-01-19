data "terraform_remote_state" "network" {
  backend = "local"

  config {
    path = "../network/terraform.tfstate"
  }
}

resource "null_resource" "key-create" {
  provisioner "local-exec" {
    command = "ssh-keygen -b 4096 -t rsa -N '' -C ${data.terraform_remote_state.network.default_name}.pub -f ${data.terraform_remote_state.network.default_name}.pem"
  }
}

output "keypair" {
  value = "${data.terraform_remote_state.network.default_name}"
}
