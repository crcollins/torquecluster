#!/bin/bash
apt-get install -y torque-server torque-scheduler torque-mom torque-client

qterm
yes | pbs_server -t create
qmgr -c "set server acl_hosts=master"
qmgr -c "set server scheduling=true"
qmgr -c "create queue batch queue_type=execution"
qmgr -c "set queue batch started=true"
qmgr -c "set queue batch enabled=true"
qmgr -c "set queue batch resources_default.nodes=1"
qmgr -c "set queue batch resources_default.walltime=3600"
qmgr -c "set server default_queue=batch"
qmgr -c "set server keep_completed = 10"

echo  "master np=1" > /var/spool/torque/server_priv/nodes
for i in `seq 1 $1`; do echo  "slave$i np=1" >> /var/spool/torque/server_priv/nodes; done

cat > /var/spool/torque/mom_priv/config <<EOF
\$pbsserver      master
\$logevent       255
EOF
qterm
pbs_server