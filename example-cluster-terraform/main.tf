terraform {
required_version = ">= 0.13.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
}

resource "openstack_compute_keypair_v2" "demo" {
  name = "demo-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "openstack_compute_instance_v2" "demo" {
  count = var.num_instances
  name = "demo-${count.index}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = "m1.tiny"
  security_groups = ["default", "demo-sg"]
  key_pair = openstack_compute_keypair_v2.demo.name

  network {
    name = openstack_networking_network_v2.demo.name
  }
}

resource "openstack_compute_floatingip_associate_v2" "demo" {
  count = var.num_instances
  floating_ip = element(openstack_networking_floatingip_v2.demo.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.demo.*.id, count.index)
}

output "server_ips" {
  value = openstack_compute_floatingip_associate_v2.demo.*.floating_ip
}
