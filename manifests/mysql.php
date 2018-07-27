include '::mysql::server'.

class { '::mysql::server':
  root_password           => 'superduperstrong',
  remove_default_accounts => true,
}
