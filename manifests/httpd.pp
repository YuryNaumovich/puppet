node 'slave1.puppet','slave2.puppet' {

class { 'httpd_install_and_running': } 
class { 'git_clone': } 
class httpd_listen_port (
$listen_port = 8080)

  file {'/etc/httpd/conf.d/vh_static.conf':
  notify => Service["httpd"],
    ensure => file,
    require => Package["httpd"],
    content => template("/etc/puppetlabs/code/environments/production/files/vh_static.conf"),
  }

  
}
