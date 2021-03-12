resource "openstack_networking_network_v2" "pulsar" {
  name           = "pulsar-net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "pulsar" {
  name       = "pulsar-subnet"
  network_id = openstack_networking_network_v2.pulsar.id
  cidr       = var.cidr
}

resource "openstack_networking_router_v2" "pulsar" {
  name             = "pulsar-router"
  admin_state_up   = true
  external_network_id = var.public_network_id
}

resource "openstack_networking_router_interface_v2" "pulsar" {
  router_id = openstack_networking_router_v2.pulsar.id
  subnet_id = openstack_networking_subnet_v2.pulsar.id
}
