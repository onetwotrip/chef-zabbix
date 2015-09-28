#
# Cookbook Name:: zabbix
# Recipe:: default
#


case node.platform_family
when 'debian'
  include_recipe 'apt'
  # use 2.4 for trusty, 2.0 elsewhere
  case node['lsb']['codename']
  when 'trusty'
    zbx_uri = "http://repo.zabbix.com/zabbix/2.4/ubuntu"
  else
    zbx_uri = "http://repo.zabbix.com/zabbix/2.0/ubuntu"
  end
  apt_repository "official-zabbix-repo" do
    uri zbx_uri
    distribution node['lsb']['codename']
    key 'http://repo.zabbix.com/zabbix-official-repo.key'
    components ["main"]
    action :add
  end
end

include_recipe 'zabbix::agent'
include_recipe 'zabbix::sudo'
