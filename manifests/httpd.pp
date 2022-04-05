node 'slave*.puppet' {
              package { 'httpd' :
              ensure => installed,
                       }
}
