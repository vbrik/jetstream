# 
# zookeepers
#
resource "openstack_compute_instance_v2" "zookeeper" {
  count = var.zookeeper_count
  name = "zookeeper-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["zookeeper"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_networking_floatingip_v2" "zookeeper" {
  count = var.zookeeper_count
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "zookeeper" {
  count = var.zookeeper_count
  floating_ip = element(openstack_networking_floatingip_v2.zookeeper.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.zookeeper.*.id, count.index)
}

output "zookeeper_ips" {
  value = openstack_compute_floatingip_associate_v2.zookeeper.*.floating_ip
}

# 
# bookies
#
resource "openstack_compute_instance_v2" "bookie" {
  count = var.bookie_count
  name = "bookie-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["bookie"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_networking_floatingip_v2" "bookie" {
  count = var.bookie_count
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "bookie" {
  count = var.bookie_count
  floating_ip = element(openstack_networking_floatingip_v2.bookie.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.bookie.*.id, count.index)
}

output "bookie_ips" {
  value = openstack_compute_floatingip_associate_v2.bookie.*.floating_ip
}

# 
# brokers
#
resource "openstack_compute_instance_v2" "broker" {
  count = var.broker_count
  name = "broker-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["broker"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_networking_floatingip_v2" "broker" {
  count = var.broker_count
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "broker" {
  count = var.broker_count
  floating_ip = element(openstack_networking_floatingip_v2.broker.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.broker.*.id, count.index)
}

output "broker_ips" {
  value = openstack_compute_floatingip_associate_v2.broker.*.floating_ip
}

# 
# proxies
#
resource "openstack_compute_instance_v2" "proxy" {
  count = var.proxy_count
  name = "proxy-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["proxy"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_networking_floatingip_v2" "proxy" {
  count = var.proxy_count
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "proxy" {
  count = var.proxy_count
  floating_ip = element(openstack_networking_floatingip_v2.proxy.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.proxy.*.id, count.index)
}

output "proxy_ips" {
  value = openstack_compute_floatingip_associate_v2.proxy.*.floating_ip
}
