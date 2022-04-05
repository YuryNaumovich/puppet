'slave1.puppet' {
 file {'/tmp/it_works': 
  ensure => present,
  content => 'It works',
   }
  }
