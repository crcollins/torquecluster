# -*- mode: ruby -*-
# vi: set ft=ruby :

id_rsa_ssh_key_pub = File.read("id_rsa.pub")

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
 config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--memory", "512"]
  end

  numNodes = ENV["NODES"].to_i
  puts numNodes
  config.vm.define :master do |master|
    master.vm.box = "precise32"
    master.vm.box_url = "http://files.vagrantup.com/precise32.box"
    master.vm.network :private_network, ip: "192.168.1.100"
    master.vm.hostname = "master"

    config.vm.provision :shell, :inline => "echo 'Copying public Key to VM auth_keys...' && mkdir -p /home/vagrant/.ssh && echo '#{id_rsa_ssh_key_pub }' >> /home/vagrant/.ssh/authorized_keys && chmod 600 /home/vagrant/.ssh/authorized_keys"

    master.vm.provision :shell, :path => "hosts.sh", :args => "'%d'" % numNodes
    master.vm.provision :shell, :path => "master.sh", :args => "'%d'" % numNodes
    master.vm.provision :shell, :path => "both.sh"
  end

  1.upto(numNodes) do |num|
    nodeName = ("slave" + num.to_s).to_sym
    val = num + 100
    config.vm.define nodeName do |node|
      node.vm.box = "precise32"
      node.vm.box_url = "http://files.vagrantup.com/precise32.box"
      node.vm.network :private_network, ip: "192.168.1." + val.to_s
      node.vm.hostname = "slave" + num.to_s
      node.vm.provision :shell, :path => "hosts.sh", :args => "'%d'" % numNodes
      node.vm.provision :shell, :path => "slave.sh", :args => "'%d'" % num
      node.vm.provision :shell, :path => "both.sh"
    end
  end
end
