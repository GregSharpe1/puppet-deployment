node 'jenkins' {

  exec { "apt-update":
      command => "/usr/bin/apt-get update"
  }

  # We have decided to attempt to create the manifest ourselves
  # Install Java8 on Ubuntu14.04 is a little different
  include apt

  apt::ppa{ 'ppa:jonathonf/openjdk': }

  package { 'java8': 
    name => "openjdk-8-jdk",
    ensure => installed,
    require => Exec['apt-update'],
  } 

  # According to the installion docs from Jenkins.io 
  # https://jenkins.io/doc/book/installing/

  # First step is to add the gpg key to the list of trusted keys

  apt::key {
    'D50582E6':
      source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
  }

  # apt::source {
  #   'jenkins':
  #     ensure  => present,
  #     content => 'deb http://pkg.jenkins-ci.org/debian-stable binary/',
  #     # The above gives you the LTS release. Use the below repo to get the very latest
  #     # content => 'deb http://pkg.jenkins-ci.org/debian binary/',
  #     require => Apt::Key['D50582E6'],
  # }

  apt::source { 'jenkins':
    comment => 'This is the Jenkins install',
    location => 'http://pkg.jenkins-ci.org/debian-stable',
    repos => 'binary',
    include => {
      'src' => true,
    },
  }

  package { 'jenkins':
    name => 'jenkins',
    ensure => installed,
    require => Exec['apt-update'],
  }

  service { 'jenkins':
    name => 'jenkins',
    ensure  => running,
    enable  => true,
    require => Package['jenkins'],
  }
}
