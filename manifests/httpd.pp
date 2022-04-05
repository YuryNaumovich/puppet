node /^slave\d+$/ {
              package { 'httpd' :
              ensure => installed,
                       }
}
