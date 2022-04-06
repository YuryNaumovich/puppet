class virtual_host_file
($vh_file = 'vh_static.conf')
{
 file {"/etc/httpd/conf.d/$vh_file":
  notify => Service["httpd"],
    ensure => file,
    require => Package["httpd"],
    content => template("/etc/puppetlabs/code/environments/production/files/$vh_file"),
   }
  }
