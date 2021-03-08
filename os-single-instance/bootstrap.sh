#!/bin/bash

#openstack security group create --description "ssh & icmp enabled" ${OS_USERNAME}-global-ssh
#openstack security group rule create --protocol tcp --dst-port 22:22 --remote-ip 0.0.0.0/0 ${OS_USERNAME}-global-ssh
#openstack security group rule create --protocol icmp ${OS_USERNAME}-global-ssh

#openstack keypair create --public-key ~/.ssh/id_rsa.pub ${OS_USERNAME}-api-key

#openstack router create ${OS_USERNAME}-api-router
#openstack router set --external-gateway public ${OS_USERNAME}-api-router
#openstack router add subnet ${OS_USERNAME}-api-router ${OS_USERNAME}-api-subnet1
#openstack router show ${OS_USERNAME}-api-router

#openstack flavor list

#openstack image list --limit 1000  |  grep JS-API-Featured

openstack server create ${OS_USERNAME}-api-U-1 \
--flavor m1.tiny \
--image IMAGE-NAME \
--key-name ${OS_USERNAME}-api-key \
--security-group ${OS_USERNAME}-global-ssh \
--nic net-id=${OS_USERNAME}-api-net

openstack floating ip create public

openstack server add floating ip ${OS_USERNAME}-api-U-1 your.ip.number.here

ssh -i ${OS_USERNAME}-api-key centos@your.ip.number.here
    or
ssh -i ${OS_USERNAME}-api-key ubuntu@your.ip.number.here


#openstack server reboot ${OS_USERNAME}-api-U-1
#openstack server suspend ${OS_USERNAME}-api-U-1
#openstack server stop ${OS_USERNAME}-api-U-1
#openstack server shelve ${OS_USERNAME}-api-U-1
#
#
#openstack server remove floating ip ${OS_USERNAME}-api-U-1 your.ip.number.here
#openstack server delete ${OS_USERNAME}-api-U-1
#openstack floating ip delete your.ip.number.here
#
#openstack router unset --external-gateway ${OS_USERNAME}-api-router
#openstack router remove subnet ${OS_USERNAME}-api-router ${OS_USERNAME}-api-subnet1
#openstack router delete ${OS_USERNAME}-api-router
