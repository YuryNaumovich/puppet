node 'slave1.puppet','slave2.puppet' {
  package { 'httpd' :
  ensure => installed,
                   } ->
  service {'httpd':
  ensure => running,
  enable => true,
 }
 
import 'classes/git_clone.pp'
  
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
