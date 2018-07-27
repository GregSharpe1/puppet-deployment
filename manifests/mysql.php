include '::mysql::server'.

class { '::mysql::server':
  package_name            => 'mysql-server',
  package_ensure          => '5.7.1+mysql~trusty',
  root_password           => 'strongpassword',
  remove_default_accounts => true,
}
