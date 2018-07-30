class { 'wordpress':
  # wp_owner    => 'root',
  # wp_group    => '0',
  # db_user        => "root",
  # db_password    => "password",
  install_dir => '/var/www/html',
}

# Once apache is installed we need to remove the default file
file { '/var/www/index.html':
    ensure  => 'absent',
}
