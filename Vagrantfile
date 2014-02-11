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
for i in `seq 1 $1`; do echo  "192.168.1.10$i   slave$i" >> /etc/hosts; done
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
  config.vm.define :master do |master|
    master.vm.box = "precise32"
    master.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    master.vm.network :private_network, ip: "192.168.1.100"
    master.vm.hostname = "master"
    master.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    master.vm.provision :shell, :inline => $master_script, :args => "'4'"
  end

  config.vm.define :slave1 do |slave1|
    slave1.vm.box = "precise32"
    slave1.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    slave1.vm.network :private_network, ip: "192.168.1.101"
    slave1.vm.hostname = "slave1"
    slave1.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    slave1.vm.provision :shell, :inline => $slave_script, :args => "'1'"
  end

  config.vm.define :slave2 do |slave2|
    slave2.vm.box = "precise32"
    slave2.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    slave2.vm.network :private_network, ip: "192.168.1.102"
    slave2.vm.hostname = "slave2"
    slave2.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    slave2.vm.provision :shell, :inline => $slave_script, :args => "'2'"
  end

  config.vm.define :slave3 do |slave3|
    slave3.vm.box = "precise32"
    slave3.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    slave3.vm.network :private_network, ip: "192.168.1.103"
    slave3.vm.hostname = "slave3"
    slave3.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    slave3.vm.provision :shell, :inline => $slave_script, :args => "'3'"
  end

  config.vm.define :slave4 do |slave4|
    slave4.vm.box = "precise32"
    slave4.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
    end
    slave4.vm.network :private_network, ip: "192.168.1.104"
    slave4.vm.hostname = "slave4"
    slave4.vm.provision :shell, :inline => $hosts_script, :args => "'4'"
    slave4.vm.provision :shell, :inline => $slave_script, :args => "'4'"
  end
end
