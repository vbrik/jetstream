#!/bin/bash

name=vbrik-1

openstack server create $name \
--flavor m1.tiny \
--image JS-API-Featured-CentOS8-Latest \
--key-name ${OS_USERNAME}-api-key \
--security-group ${OS_USERNAME}-global-ssh \
--nic net-id=public
