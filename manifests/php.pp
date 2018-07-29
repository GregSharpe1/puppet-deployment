include apache::mod::php

class { "php": }

# Install a custom php module
package { 'php5-mysqlnd-ms':
  ensure => installed,
}
