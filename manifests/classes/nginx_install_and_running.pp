class nginx_install_and_running
{
package { 'nginx' :
  ensure => installed,
                   } ->
  service {'nginx':
  ensure => running,
  enable => true,
   }
  }
