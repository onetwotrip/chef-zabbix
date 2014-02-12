# -*- mode: ruby -*-
# vi: set ft=ruby :

chef_run_list =  [
  "recipe[apt]",
  "recipe[zabbix::default]",
  "recipe[twiket-utils]"
]

Vagrant.configure("2") do |config|
  config.vm.hostname = "chef-zabbix-berkshelf"
  #config.vm.box      = "opscode-ubuntu-10.04"
  config.vm.box      =  "lucid64-rvm-chef11"
  config.vm.box_url  = "http://opscode-vagrant-boxes.s3.amazonaws.com/ubuntu10.04-gems.box"
  config.vm.network :private_network, ip: "33.33.33.10"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false

    # vb.customize ["modifyvm", :id, "--memory", "1024"]
  end

  #config.omnibus.chef_version = '11.8.2'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['/tmp/logstash-cookbooks']
    chef.provisioning_path = '/etc/vagrant-chef'
    chef.json = {}
    chef.run_list = chef_run_list
  end
end
