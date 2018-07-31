node 'jenkins' {

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
    refreshonly => true,
  }

  class { 'apt':
    always_apt_update => true,
  }

  # We have decided to attempt to create the manifest ourselves
  # Install Java8 on Ubuntu14.04 is a little different
  include apt

  apt::ppa{ 'ppa:jonathonf/openjdk': }

  package { 'java8':
    name => "openjdk-8-jdk",
    ensure => installed,
    notify => Exec['apt-update'],
  }

  # According to the installion docs from Jenkins.io
  # https://jenkins.io/doc/book/installing/

  # First step is to add the gpg key to the list of trusted keys

  apt::key {
    'D50582E6':
      source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    notify => Exec['apt-update'],
  }

  apt::source { 'jenkins':
    comment => 'This is the Jenkins install',
    location => 'http://pkg.jenkins-ci.org/debian-stable',
    release => '',
    repos => 'binary/',
    include => {
      'deb' => true,
    },
  }

  package { 'jenkins':
    name => 'jenkins',
    ensure => installed,
    require => Exec['apt-update'],
  }

  # Before starting the jenkins service we must edit the /etc/default/jenkins file
  # to allow the -Djenkins.install.runSetupWizard=false flag under JAVA_OPTION variable.
  exec { 'add jenkins java variable':
    command => '/bin/echo "JAVA_ARGS=\"-Djava.install.runSetupWizard=false\"" >> /etc/default/jenkins',
    #require = 
  }

  service { 'jenkins':
    name => 'jenkins',
    ensure  => running,
    enable  => true,
    before => Exec['add jenkins java variable'],
  }
}
