resource "openstack_networking_floatingip_v2" "demo" {
  count = var.num_instances
  pool  = "public"
}

resource "openstack_networking_secgroup_v2" "demo" {
  name = "demo-sg"
}

resource "openstack_networking_secgroup_rule_v2" "global-ssh-ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.demo.id
}

resource "openstack_networking_network_v2" "demo" {
  name           = "demo-net"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "demo" {
  name       = "demo-subnet"
  network_id = openstack_networking_network_v2.demo.id
  cidr       = var.cidr
}

resource "openstack_networking_router_v2" "demo" {
  name             = "demo-router"
  admin_state_up   = true
  external_network_id = var.public_network_id
}

resource "openstack_networking_router_interface_v2" "demo" {
  router_id = openstack_networking_router_v2.demo.id
  subnet_id = openstack_networking_subnet_v2.demo.id
}
