node 'slave1.puppet' {
class { 'httpd_install_and_running': } 
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8080'}
class { 'virtual_host_file': vh_file => 'vh_static.conf'}
class { 'open_firewall_port': open_port => '8080'}
service { 'firewalld':
  ensure => 'running',
  start   => '/usr/bin/systemctl start firewalld',
  stop    => '/usr/bin/systemctl stop firewalld',
  restart => '/usr/bin/systemctl restart firewalld'
}
}

node 'slave2.puppet' {
class { 'httpd_install_and_running': }
class { 'php_install': }
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8008'}
class { 'virtual_host_file': vh_file => 'vh_dynamic.conf'}
class { 'open_firewall_port': open_port => '8008'}

exec { 'myservice-systemd-reload':
  command     => 'systemctl restart firewalld',
  path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  user => 'root',
}

}
