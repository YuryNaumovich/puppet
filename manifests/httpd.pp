node '/.*\.puppet$/ { ... }' {
              package { 'httpd' :
              ensure => installed,
                       }
}
