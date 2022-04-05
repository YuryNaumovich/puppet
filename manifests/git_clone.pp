class git_clone {
vcsrepo { '/var/www/html':
  ensure   => present,
  provider => git,
  source   => 'https://github.com/Fenikks/itacademy-devops-files',
 }
}
