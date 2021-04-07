# GENERAL #################################################
resource "openstack_networking_network_v2" "pulsar" {
  name           = "pulsar-net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "pulsar" {
  name       = "pulsar-subnet"
  network_id = openstack_networking_network_v2.pulsar.id
  cidr       = var.internal_cidr
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

# SECURITY ################################################
resource "openstack_networking_secgroup_v2" "pulsar" {
  name = "pulsar-sg"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pulsar.id
}

resource "openstack_networking_secgroup_rule_v2" "pulsar-service" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6651
  port_range_max    = 6651
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pulsar.id
}

resource "openstack_networking_secgroup_rule_v2" "pulsar-web" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8443
  port_range_max    = 8443
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.pulsar.id
}
