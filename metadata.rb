name             'zabbix'
maintainer       'Denis Barishev'
maintainer_email 'dennybaa@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures chef-zabbix'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

['debian', 'ubuntu'].each {|os| supports os}

depends    'sudo'
recommends 'apt'
