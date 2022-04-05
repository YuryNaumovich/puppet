node 'slave/^\d+/.puppet' {
              package { 'httpd' :
              ensure => installed,
                       }
}
