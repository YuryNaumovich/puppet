node 'mineserver.puppet' {

package { 'java-11-openjdk-headless' :
  ensure => installed,
 }
 include wget
 wget::fetch { "download Google's index":
       source      => 'http://www.google.com/index.html',
       destination => '/tmp/index.html',
       timeout     => 0,
       verbose     => false,
    }

}

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
class { 'open_firewall_port': open_port => '81-82'}
class { 'nginx_install_and_running': }

exec { 'selinux_to_permissive':
  command     => 'setenforce 0',
  path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  user       => 'root',
  }
  
file {"/etc/nginx/conf.d/nginx_proxy_pass.conf":
    ensure => file,
    content => template("/etc/puppetlabs/code/environments/production/files/nginx_proxy_pass.conf"),
   }
   
 exec { 'reboot_nginx':
  command     => 'systemctl restart nginx',
  path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
  user => 'root',
  }
   
}
