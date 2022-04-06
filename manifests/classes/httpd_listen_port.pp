class httpd_listen_port 
($listen_port = '8080')
{
   file_line { 'Listen service':
      ensure            => present,
      path              => '/etc/httpd/conf/httpd.conf',
      line              => "Listen $listen_port",
      match             => '^Listen',
      match_for_absence => true,
   }
 }
    
