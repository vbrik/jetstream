#!/bin/bash
# Based on https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/35913730/OpenStack+command+line

set -ex

openstack security group create demo-sg
openstack security group rule create --protocol icmp demo-sg
openstack security group rule create --protocol tcp \
        --dst-port 22:22 --remote-ip 0.0.0.0/0 demo-sg

openstack keypair create --public-key ~/.ssh/id_rsa.pub demo-key


openstack network create demo-network
openstack subnet create --network demo-network --subnet-range 10.0.0.0/24 demo-subnet

openstack router create demo-router
openstack router set --external-gateway public demo-router
openstack router add subnet demo-router demo-subnet
openstack router show demo-router

for i in 0 1; do 
	openstack server create demo-$i \
			--flavor m1.tiny \
			--image JS-API-Featured-CentOS8-Latest \
			--key-name demo-key \
			--security-group demo-sg \
			--nic net-id=demo-network
	openstack floating ip create public
done

fips="$(openstack floating ip list -f json)"
for i in 0 1; do
	ip=$(echo "$fips" | jq ".[$i].\"Floating IP Address\"" | tr -d \")
	openstack server add floating ip demo-$i $ip
done

openstack floating ip list
#ssh -i ${OS_USERNAME}-api-key centos@your.ip.number.here
#    or
#ssh -i ${OS_USERNAME}-api-key ubuntu@your.ip.number.here


#openstack server reboot ${OS_USERNAME}-api-U-1
#openstack server suspend ${OS_USERNAME}-api-U-1
#openstack server stop ${OS_USERNAME}-api-U-1
#openstack server shelve ${OS_USERNAME}-api-U-1
