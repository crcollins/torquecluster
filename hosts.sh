#!/bin/bash
cat > /etc/hosts <<EOF
127.0.0.1       localhost

# The following lines are desirable for IPv6 capable hosts
::1     ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters

192.168.1.100   master torqueserver
EOF
for i in `seq 1 $1`; do echo "192.168.1.10$i   slave$i" >> /etc/hosts; done