class git_clone 
($git_repositories = 'https://github.com/Fenikks/itacademy-devops-files')
{
vcsrepo { '/var/www/html':
   ensure   => present,
   provider => git,
   source   => "$git_repositories",
   }
  }
