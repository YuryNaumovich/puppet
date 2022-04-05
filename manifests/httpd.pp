node 'slave1.puppet','slave2.puppet' {
  package { 'httpd' :
  ensure => installed,
 }
}
