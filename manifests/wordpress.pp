node 'agent' {

  # MySQL related shit
  class { '::mysql::server': 
      remove_default_accounts => true,
  }

  include mysql::server

  # Wordpress related 
  class { 'wordpress':
    install_dir => '/var/www/html',
  }

  # Apache related goodness
  class { 'apache':  
    mpm_module => 'prefork'
  }
  # Once apache is installed we need to remove the default file
  file { '/var/www/html/index.html':
      ensure  => 'absent',
  }

  # PHP related sexyiness
  include apache::mod::php

  class { "php": }

  # Install a custom php module
  package { 'php5-mysqlnd-ms':
    ensure => installed,
  }
}
