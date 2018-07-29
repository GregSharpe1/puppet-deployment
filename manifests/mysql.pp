class { '::mysql::server': }

# Install mysql server then create the wordpress database
mysql::db { 'wordpress':
  user => 'wordpress',
  password => 'wordpress_password',
  host => 'localhost',
  grant => ['ALL']
}
