#
# Cookbook Name:: zabbix
# Recipe:: sudo
#

include_recipe 'sudo'

# Sudo invocation is wrapped into ruby_block which will be evaluated
# at the end of chef run, this provides lazy attribute evaluation.
#
ruby_block 'zabbix_sudo delayed job' do
  action :nothing
  block do
    commands = node['zabbix']['agent']['sudo_commands'] || []
    unless commands.empty?
      sudo = Chef::Resource::Sudo.new('zabbix_sudo', run_context)
      sudo.instance_eval do
        user     'zabbix'
        runas    'root'
        nopasswd true
        commands commands
      end
      Chef::Provider::Sudo.new(sudo, run_context).run_action(:install)
    end
  end
end

ruby_block 'fake_zabbix_sudo_notifier' do
  block    {}
  notifies :create, 'ruby_block[zabbix_sudo delayed job]', :delayed
end
