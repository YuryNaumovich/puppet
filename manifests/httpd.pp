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
}

node 'slave1.puppet' {
 file { "/etc/httpd/conf.d/vb_static.conf":
        mode => "0755",
        owner => 'www-data',
        group => 'www-data',
        source => 'puppet:///production/files/vb_static.conf',
    }
}
