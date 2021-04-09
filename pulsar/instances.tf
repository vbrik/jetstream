# 
# zookeepers
#
resource "openstack_compute_instance_v2" "zookeeper-int" {
  count = var.instance_counts["zookeeper"]
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
  count = var.instance_counts["zookeeper"]
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "zookeeper" {
  count = var.instance_counts["zookeeper"]
  floating_ip = element(openstack_networking_floatingip_v2.zookeeper.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.zookeeper-int.*.id, count.index)
}

# 
# bookies
#
resource "openstack_compute_instance_v2" "bookie-int" {
  count = var.instance_counts["bookie"]
  name = "bookie-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["bookie"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_blockstorage_volume_v2" "vol" {
  count = var.instance_counts["bookie"]
  name = format("vol-%02d", count.index + 1)
  size = var.bookie_volume_size
}

resource "openstack_compute_volume_attach_v2" "va-bookie" {
  count = var.instance_counts["bookie"]
  instance_id = openstack_compute_instance_v2.bookie-int[count.index].id
  volume_id   = openstack_blockstorage_volume_v2.vol[count.index].id
}

resource "openstack_networking_floatingip_v2" "bookie" {
  count = var.instance_counts["bookie"]
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "bookie" {
  count = var.instance_counts["bookie"]
  floating_ip = element(openstack_networking_floatingip_v2.bookie.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.bookie-int.*.id, count.index)
}

# 
# brokers
#
resource "openstack_compute_instance_v2" "broker-int" {
  count = var.instance_counts["broker"]
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
  count = var.instance_counts["broker"]
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "broker" {
  count = var.instance_counts["broker"]
  floating_ip = element(openstack_networking_floatingip_v2.broker.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.broker-int.*.id, count.index)
}

# 
# proxies
#
resource "openstack_compute_instance_v2" "proxy-int" {
  count = var.instance_counts["proxy"]
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
  count = var.instance_counts["proxy"]
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "proxy" {
  count = var.instance_counts["proxy"]
  floating_ip = element(openstack_networking_floatingip_v2.proxy.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.proxy-int.*.id, count.index)
}

# 
# clients
#
resource "openstack_compute_instance_v2" "client-int" {
  count = var.instance_counts["client"]
  name = "client-${count.index + 1}"
  image_name = "JS-API-Featured-CentOS8-Latest"
  flavor_name = var.instance_types["client"]
  security_groups = ["pulsar-sg"]
  key_pair = openstack_compute_keypair_v2.pulsar.name

  network {
    name = openstack_networking_network_v2.pulsar.name
  }
}

resource "openstack_networking_floatingip_v2" "client" {
  count = var.instance_counts["client"]
  pool  = "public"
}

resource "openstack_compute_floatingip_associate_v2" "client" {
  count = var.instance_counts["client"]
  floating_ip = element(openstack_networking_floatingip_v2.client.*.address, count.index)
  instance_id = element(openstack_compute_instance_v2.client-int.*.id, count.index)
}

