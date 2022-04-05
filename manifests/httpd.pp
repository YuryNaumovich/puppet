node /^slave\d+$/ {
  package { 'httpd' :
  ensure => installed,
 }
}

node default {
  notify { 'this node did not match any of the listed definitions': }
}
