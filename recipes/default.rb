#
# Cookbook Name:: zabbix
# Recipe:: default
#

case node.platform_family
when 'debian'
  include_recipe 'apt'

  apt_repository "official-zabbix-repo" do
    uri "http://repo.zabbix.com/zabbix/2.0/ubuntu"
    distribution node['lsb']['codename']
    components ["main"]
    action :add
  end
end

include_recipe 'zabbix::agent'
include_recipe 'zabbix::sudo'
