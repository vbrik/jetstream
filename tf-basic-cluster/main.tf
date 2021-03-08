terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.35.0"
    }
  }
}

provider "openstack" {
}

resource "openstack_compute_keypair_v2" "skymap" {
  name = "skymap"
  public_key = file("/home/vbrik/.ssh/id_rsa.pub")
}

resource "openstack_compute_instance_v2" "skymap" {
  count = 7
  name = "test-server-${count.index}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = "m1.tiny"
  security_groups = ["skymap"]
  key_pair = openstack_compute_keypair_v2.skymap.name

  network {
    name = openstack_networking_network_v2.skymap.name
  }
}

resource "openstack_compute_floatingip_associate_v2" "skymap" {
  count = 7
  floating_ip = element(openstack_networking_floatingip_v2.skymap.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.skymap.*.id, count.index)
}

output "server_ips" {
  value = openstack_compute_floatingip_associate_v2.skymap.*.floating_ip
}
