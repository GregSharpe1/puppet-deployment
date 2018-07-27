$db_user = "root"
$db_pass = "superduperpassword"

class { 'wordpress':
  wp_owner    => 'www-data',
  wp_group    => '0',
  db_user        => "$db_user",
  db_password    => "$db_pass",
  install_dir => '/var/www/html',
}
