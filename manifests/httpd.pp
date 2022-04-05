node 'slave1.puppet','slave2.puppet' {
  include base::git_clone
}

{
  package { 'httpd' :
  ensure => installed,
                   } ->
  service {'httpd':
  ensure => running,
  enable => true,
 }
}
