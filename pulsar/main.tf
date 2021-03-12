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

resource "openstack_compute_keypair_v2" "pulsar" {
  name = "pulsar-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}
