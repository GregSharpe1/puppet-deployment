$db_name = "wordpress_db"
$db_user = "wordpress_user"
$db_pass = "wordpress"
$db_host = "localhost"

class { 'wordpress':
  wp_owner    => 'wwwrun',
  wp_group    => 'www',
  db_name     => "$db_name",
  db_user        => "$db_user",
  db_password    => "$db_pass",
  create_db      => false,
  create_db_user => false,
  install_dir => '/srv/www/htdocs/wp',
  db_host => "$db_host"
}