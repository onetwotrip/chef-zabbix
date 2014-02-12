#
# Cookbook Name:: zabbix
# Recipe:: agent
#

zabbix = node['zabbix']['agent']

case node.platform_family
when "debian"
  # Once the package is installed or upgraded to the version equal to the pin_version attribute
  # the pin will be set. Further upgrades will be pinned to this particular version.
  #
  add_pin = !zabbix[:pin_version].to_s.empty?
  apt_preference zabbix[:package_name] do
    pin "version #{zabbix[:pin_version]}"
    pin_priority '600'
    only_if("apt-cache policy #{zabbix[:package_name]} | grep -q #{zabbix[:pin_version]}") if add_pin
    action add_pin ? :add : :remove
  end

  apt_package zabbix[:package_name] do
    action  [:install, :upgrade]
    options '--force-yes'
  end
end

# ensure that config directory is created
directory zabbix[:conf_dir] do
  action :create
  owner  'root'
  group  'root'
end

# ensure that external scripts directory is created
directory node['zabbix'][:external_dir] do
  action :create
  owner  'root'
  group  'root'
end

service 'zabbix-agent' do
  service_name zabbix[:service_name]
  supports :status => true, :start => true, :stop => true, :restart => true
  action [ :enable ]
end

template "#{node['zabbix']['etc_dir']}/zabbix_agentd.conf" do
  source "zabbix_agentd.conf.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, "service[zabbix-agent]"
end

template "#{node['zabbix']['agent']['conf_dir']}/zabbix_userparameters.conf" do
  action :create
  owner  'root'
  group  'root'
  source 'zabbix_userparameters.conf.erb'
  notifies :restart, "service[zabbix-agent]"
end
