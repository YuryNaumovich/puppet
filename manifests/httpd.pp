node 'slave1.puppet' {
class { 'httpd_install_and_running': } 
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8080'}
class { 'virtual_host_file': vh_file => 'vh_static.conf'}
class { 'open_firewall_port': open_port => '8080'}
  
file { '/root/README':
        ensure => absent,
  }
}

node 'slave2.puppet' {
class { 'httpd_install_and_running': }
class { 'php_install': }
class { 'git_clone': } 
class { 'httpd_listen_port': listen_port => '8008'}
class { 'virtual_host_file': vh_file => 'vh_dynamic.conf'}
class { 'open_firewall_port': open_port => '8008'}

file { '/root/README':
        ensure => absent,
 }
}

node 'puppetserver' {
class { 'nginx_install_and_running': }

nginx::resource::vhost{'/site':
    server          =>  site,
    listen_port     => '80',
    proxy           =>  "http://192.168.56.1:8080",
}

}
