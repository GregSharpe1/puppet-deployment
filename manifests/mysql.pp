class { '::mysql::server': 
  root_password           => 'password',
  remove_default_accounts => true,
}

# Install mysql server then create the wordpress database
