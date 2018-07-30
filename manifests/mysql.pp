class { '::mysql::server': 
    remove_default_accounts => true,
}

# mysql::db {'wordpress':
#   user => 'wordpress',
#   password => 'password',
#   host => 'localhost',
#   ensure => 'present',
# }
# Install mysql server then create the wordpress database

include mysql::server
