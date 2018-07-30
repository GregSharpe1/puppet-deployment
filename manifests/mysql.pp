class { '::mysql::server': }

mysql::db {'wordpress':
  user => 'wordpress',
  password => 'password',
  host => 'localhost',
  ensure => 'present',
}
# Install mysql server then create the wordpress database
