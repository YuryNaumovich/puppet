node 'slave1.puppet','slave2.puppet' {

class { 'httpd_install_and_running': } 
class { 'git_clone': } 
  
  file {'/etc/httpd/conf.d/vh_static.conf':
  notify => Service["httpd"],
    ensure => file,
    require => Package["httpd"],
    content => template("/etc/puppetlabs/code/environments/production/files/vh_static.conf"),
  }
  
   file_line { 'Listen service':
      ensure            => present,
      path              => '/etc/httpd/conf/httpd.conf',
      line              => 'Listen 8080',
      match             => '^Listen',
      match_for_absence => true,
    }
  
}
