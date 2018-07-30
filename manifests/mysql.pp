node 'agent' {

  class { '::mysql::server': 
      remove_default_accounts => true,
  }

  include mysql::server

}
