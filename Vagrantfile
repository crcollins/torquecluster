# -*- mode: ruby -*-
# vi: set ft=ruby :

$hosts_script = <<SCRIPT
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
SCRIPT


$master_script = <<SCRIPT
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
qmgr -c "set server keep_completed = 86400"

echo  "master np=1" > /var/spool/torque/server_priv/nodes
for i in `seq 1 $1`; do echo  "slave$i np=1" >> /var/spool/torque/server_priv/nodes; done

cat > /var/spool/torque/mom_priv/config <<EOF
$pbsserver      master
$logevent       255
EOF
qterm
pbs_server
SCRIPT


$slave_script = <<SCRIPT
#!/bin/bash
apt-get install -y torque-client torque-mom

cat > /var/spool/torque/mom_priv/config <<EOF
$pbsserver      slave$1
$logevent       255
EOF
SCRIPT



VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
  end

  config.vm.define :master do |master|
    master.vm.box = "precise32"
    master.vm.network :private_network, ip: "192.168.1.100"
    master.vm.hostname = "master"
    master.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    master.vm.provision :shell, :inline => $master_script, :args => "'4'"
  end

  1.upto(4) do |num|
    nodeName = ("slave" + num.to_s).to_sym
    val = num + 100
    config.vm.define nodeName do |node|
      node.vm.box = "precise32"
      node.vm.network :private_network, ip: "192.168.1." + val.to_s
      node.vm.hostname = "slave" + num.to_s
      node.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
      node.vm.provision :shell, :inline => $slave_script, :args => "'%d'" % num
    end
  end
end
