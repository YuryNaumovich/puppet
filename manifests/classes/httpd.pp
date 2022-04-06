class httpd_install_and_running {
package { 'httpd' :
  ensure => installed,
                   } ->
  service {'httpd':
  ensure => running,
  enable => true,
   }
  }
 
 class php_install {
  package { 'php' :
  ensure => installed
   }
  }
  
