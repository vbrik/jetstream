#!/bin/bash
# Based on https://iujetstream.atlassian.net/wiki/spaces/JWT/pages/35913730/OpenStack+command+line

set -x

fips="$(openstack floating ip list -f json)"
for i in 0 1; do
	ip=$(echo "$fips" | jq ".[$i].\"Floating IP Address\"" | tr -d \")
	openstack server remove floating ip demo-$i $ip
    openstack server delete demo-$i
    openstack floating ip delete $ip
done
openstack keypair delete demo-key

openstack router unset --external-gateway demo-router
openstack router remove subnet demo-router demo-subnet
openstack router delete demo-router

openstack security group delete demo-sg

openstack subnet delete demo-subnet
openstack network delete demo-network

