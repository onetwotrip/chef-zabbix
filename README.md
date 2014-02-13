# Zabbix cookbook

Zabbix cookbook installs and configures zabbix into your system (currently supports only zabbix agent).

# Requirements

Debian and Ubuntu are supported. Depends on **sudo** cookbook.

# Usage

Just include `zabbix` recipe into your runlist to start using zabbix agent, the default recipe will include `zabbix::agent` for you.
Zabbix agent configuration attributes provide almost the full set of options available to the zabbix agent of version 2. User parameters are available to use as well as external script enrollment. A neat feature is **sudo commands**, which helps to run *superuser* commands with zabbix user privileges.

## Package installation

Zabbix agent is fetched from the official zabbix repository for debian/ubuntu. The latest version of agent currently is **2.0.10** there. Recipe uses version pining to stick to a particular version once it's been installed or upgraded. Specifically during a fresh installation if version specified by `:pin_version` attribute doesn't exist, no pinning will take place.

## Using user parameters and sudo

It's very simple, the proposed method suggests to configure user parameters and sudo on recipe level, however you are free to use roles and environments.

- **`node['zabbix']['agent']['user_parameters']`** - is a hash, of item to command mappings.
- **`node['zabbix']['agent']['sudo_commands']`** - is a list of commands, which zabbix user can run using sudo.

Example usage, looks like this:


    # Shorewall recipe

    include_recipe 'zabbix'

    zabbix = node.default['zabbix']['agent']
    zabbix['user_parameters']['shorewall.status'] = 'sudo -n /sbin/shorewall status | grep -q Started ; echo $?'
    zabbix['sudo_commands'] << '/sbin/shorewall status'

# Attributes

## zabbix.agent attributes
- **:conf_dir** - zabbix agent configuration directory. Default is `"#{node['zabbix']['etc_dir']}/zabbix_agentd.d"`.
- **:pin_version** - version to which upgrade is pinned. Default is `'1:2.0.10-1'`.
- **:service_name** - init service name. For debian is `'zabbix-agent'`.
- **:package_name** - package name. For debian is `'zabbix-agent'`.
- **:servers** - set to specify zabbix servers list. Default is `[]`.
- **:servers_active** - set to specify zabbix servers list for active checks. Can contain not only IPs but IP:PORT elements. Default is `[]`.
- **:listen_port** - agent listen port. Default is `10050`.
- **:listen_ip** - agent listen ip. Default is `'::'`.
- **:pid_file** - pid file path.
- **:log_file** - log file path.
- **:log_file_size** - log file size in MB. *No default*.
- **:debug_level** - debug level. *No default*.
- **:source_ip** - source ip which uses agent. *No default*.
- **:start_agents** - number of preforked agent processes. *No default*.
- **:hostname** - agent host name. If not specified **node.hostname** is used. *No default*.
- **:timeout** - timeout for commands executed by agent. *No default*.
- **:enable_remote_commands** - enables remote zabbix agent commands. Default is `false`.
- **:max_lines_per_second** - number of lines an item can process per second. Default `100`.
- **:refresh_active_checks** - interval to refresh active checks. *No default*.
- **:user_parameters** - user parameters configuration hash. Default is `{}`.
- **:sudo_commands** - list of commands which zabbix user can invoke using sudo. Default is `[]`.

For more detailed description of attributes and that what they configure consult with [zabbix documentation](http://www.zabbix.com/documentation.php).

# Author

Author:: Denis Barishev (<dennybaa@gmail.com>)
