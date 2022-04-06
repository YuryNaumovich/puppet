node 'slave1.puppet' {
class { 'httpd_install_and_running': } 
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8080'}
class { 'virtual_host_file': vh_file => 'vh_static.conf'}
class { 'open_firewall_port': open_port => '8080'}
}

node 'slave2.puppet' {
exec { sudo setenforce 0 }
class { 'httpd_install_and_running': }
class { 'php_install': }
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8081'}
class { 'virtual_host_file': vh_file => 'vh_dynamic.conf'}
class { 'open_firewall_port': open_port => '8081'}
}
