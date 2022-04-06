class open_firewall_port 
($open_port = '8080')
{
firewalld_port { 'Open port 8080 in the public zone':
    ensure   => present,
    zone     => 'public',
    port     => "$open_port",
    protocol => 'tcp',
   }
  }
