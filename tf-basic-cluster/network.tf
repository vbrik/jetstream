resource "openstack_networking_floatingip_v2" "skymap" {
  count = 7
  pool  = "public"
}

resource "openstack_networking_secgroup_v2" "skymap" {
  name = "skymap"
}

resource "openstack_networking_secgroup_rule_v2" "global-ssh-ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.skymap.id
}

resource "openstack_networking_network_v2" "skymap" {
  name           = "skymap internal network"
  admin_state_up = "true"
}

resource "openstack_networking_subnet_v2" "skymap" {
  name       = "skymap internal subnet"
  network_id = openstack_networking_network_v2.skymap.id
  cidr       = "10.0.0.0/24"
}

resource "openstack_networking_router_v2" "skymap" {
  name             = "skymap"
  admin_state_up   = true
  external_network_id = "865ff018-8894-40c2-99b7-d9f8701ddb0b" # network "public"
}

resource "openstack_networking_router_interface_v2" "skymap" {
  router_id = openstack_networking_router_v2.skymap.id
  subnet_id = openstack_networking_subnet_v2.skymap.id
}
