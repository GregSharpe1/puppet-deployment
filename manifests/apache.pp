class { 'apache':  
  mpm_module => 'prefork'
}

# Once apache is installed we need to remove the default file
file { '/var/www/index.html':
    ensure  => 'absent',
}
