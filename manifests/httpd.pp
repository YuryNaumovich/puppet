'slave1.puppet' {
 file {'/etc/issue': 
  ensure => present,
  content => It works,
   }
  }
