output "zookeeper_pub_ips" {
  value = openstack_compute_floatingip_associate_v2.zookeeper.*.floating_ip
}
output "bookie_pub_ips" {
  value = openstack_compute_floatingip_associate_v2.bookie.*.floating_ip
}
output "broker_pub_ips" {
  value = openstack_compute_floatingip_associate_v2.broker.*.floating_ip
}
output "proxy_pub_ips" {
  value = openstack_compute_floatingip_associate_v2.proxy.*.floating_ip
}
output "client_pub_ips" {
  value = openstack_compute_floatingip_associate_v2.client.*.floating_ip
}

output "zookeeper_priv_ips" {
  value = openstack_compute_instance_v2.zookeeper-int.*.access_ip_v4
}
output "bookie_priv_ips" {
  value = openstack_compute_instance_v2.bookie-int.*.access_ip_v4
}
output "broker_priv_ips" {
  value = openstack_compute_instance_v2.broker-int.*.access_ip_v4
}
output "proxy_priv_ips" {
  value = openstack_compute_instance_v2.proxy-int.*.access_ip_v4
}
output "client_priv_ips" {
  value = openstack_compute_instance_v2.client-int.*.access_ip_v4
}

