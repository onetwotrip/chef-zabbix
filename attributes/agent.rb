zabbix = default['zabbix']['agent']

zabbix[:conf_dir]       = "#{node['zabbix']['etc_dir']}/zabbix_agentd.d"
zabbix[:pin_version]    = '1:2.0.10-1'
zabbix[:service_name]   = 'zabbix-agent'
zabbix[:package_name]   = 'zabbix-agent'
zabbix[:servers]        = []  # ip list
zabbix[:servers_active] = []  # ip || ip:port listRUBY_TO_INSTALL

zabbix[:listen_port]    = 10050
zabbix[:listen_ip]      = '::'
zabbix[:pid_file]       = '/var/run/zabbix/zabbix_agentd.pid'
zabbix[:log_file]       = '/var/log/zabbix/zabbix_agentd.log'
zabbix[:log_file_size]  = nil
zabbix[:debug_level]    = nil # 0-4, if not set 3 is used
zabbix[:source_ip]      = nil
zabbix[:start_agents]   = nil
zabbix[:hostname]       = nil
zabbix[:timeout]        = nil # range 3-30
zabbix[:enable_remote_commands] = false
zabbix[:max_lines_per_second]   = 100
zabbix[:refresh_active_checks]  = nil

zabbix[:user_parameters] = {}
zabbix[:sudo_commands]   = []
