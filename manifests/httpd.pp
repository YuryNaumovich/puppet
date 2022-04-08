node 'mineserver.puppet' {
class { 'open_firewall_port': open_port => '25565'}

package { 'java-17-openjdk-headless' :
  ensure => installed,
 }
 
file { '/opt/minecraft':
    ensure => 'directory',
  }
  
exec { 'get_minecraft':
  cwd     => '/opt/minecraft',
  command => '/bin/wget https://launcher.mojang.com/v1/objects/c8f83c5655308435b3dcf03c06d9fe8740a77469/server.jar',
  path    => ['/usr/bin', '/usr/sbin',],
  creates => '/opt/minecraft/server.jar',
}

file_line { 'agreement to our EULA':
  ensure  => present,
  match   => "^eula=false",
  path    => '/opt/minecraft/eula.txt',
  line    => 'eula=true',
 }

file { '/etc/systemd/system/mineserver.service':
  ensure => file,
  owner  => 'root',
  group  => 'root',
  mode   => '0644',
  content => template("/etc/puppetlabs/code/environments/production/files/mineserver.service"),
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
