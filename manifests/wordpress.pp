class { 'wordpress':
  install_dir => '/var/www/html',
}

# Once apache is installed we need to remove the default file
file { '/var/www/html/index.html':
    ensure  => 'absent',
}
