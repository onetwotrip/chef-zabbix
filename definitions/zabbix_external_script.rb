#
# Cookbook Name:: zabbix
# Definition:: zabbix_external_script
#

define :zabbix_external_script, :source => nil, :enable => true do
  timing = params[:timing] || :none
  if params[:source]
    config = params[:config] || params[:name]
  else
    # source isn't given, so take of .erb extension
    config = ::File.basename(params[:name])
  end
  config.sub!(/\.erb$/, '')
  source = params[:source] || params[:name]

  method = ::File.extname(source) == '.erb' ? :template : :cookbook_file
  file_pass = [:owner, :group, :backup, :mode, :cookbook]
  tpl_pass  = [:local, :variables]

  config_path = ::File.join(node['zabbix'][:external_dir], config)
  file_block = Proc.new do
    action(params[:enable] ? :create : :delete)
    path   config_path
    source source
    mode   0755 # default mode
    # will pass specified attributes if any of them are given
    file_pass.each {|a| self.send(params[a]) if params[a]}
    tpl_pass.each {|a| self.send(params[a]) if params[a]} if method == :template
  end

  self.send(method, config_path, &file_block)
end
