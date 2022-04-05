node 'slave1.puppet','slave2.puppet' {
  package { 'httpd' :
  ensure => installed,
                   } ->
  service {'httpd':
  ensure => running,
  enable => true,
 }
 
 vcsrepo { '/var/www/html':
   ensure   => present,
   provider => git,
   source   => 'https://github.com/Fenikks/itacademy-devops-files',
  }
  
  file {'/etc/httpd/conf.d/vh_static.conf':
  notify => Service["httpd"],
    ensure => file,
    require => Package["httpd"],
    content => template("/etc/puppetlabs/code/environments/production/files/vh_static.conf"),
  }
  
}
