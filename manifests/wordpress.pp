$db_user = "root"
$db_pass = "wordpress_password"

class { 'wordpress':
  wp_owner    => 'root',
  wp_group    => '0',
  db_user        => "$db_user",
  db_password    => "$db_pass",
  install_dir => '/var/www/html',
}
