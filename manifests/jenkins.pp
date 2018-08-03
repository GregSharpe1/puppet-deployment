node 'jenkins' {

  # We have decided to attempt to create the manifest ourselves
  # Install Java8 on Ubuntu14.04 is a little different
  include apt

  apt::ppa{ 'ppa:jonathonf/openjdk':
    before => Exec['apt-update'],
  }

  # According to the installion docs from Jenkins.io
  # https://jenkins.io/doc/book/installing/

  # First step is to add the gpg key to the list of trusted keys
  apt::key {
    'D50582E6':
      source => 'http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key',
    before => Exec['apt-update'],
  }

  apt::source { 'jenkins':
    comment => 'This is the Jenkins install',
    location => 'http://pkg.jenkins-ci.org/debian-stable',
    release => '',
    repos => 'binary/',
    include => {
      'deb' => true,
    },
    before => Exec['apt-update'],
  }

  exec { "apt-update":
    command => "/usr/bin/apt-get update",
  }

  package { 'java8':
    name => "openjdk-8-jdk",
    ensure => installed,
    require => Exec['apt-update'],
  }

  package { 'jenkins':
    name => 'jenkins',
    ensure => "2.73.3",
    require => Exec['apt-update'],
  }

  service { 'start jenkins':
    name => 'jenkins',
    ensure  => running,
    enable  => true,
    require => Exec['apt-update'],
  }

  # Before starting the jenkins service we must edit the /etc/default/jenkins file
  # to allow the -Djenkins.install.runSetupWizard=false flag under JAVA_OPTION variable.
  exec { 'add jenkins java variable':
    command => '/bin/sed -i "s#JAVA_ARGS=\"-Djava.awt.headless=true\"#JAVA_ARGS=\"-Djava.awt.headless=true -Djenkins.install.runSetupWizard=false\"#g" /etc/default/jenkins',
    notify => Service['start jenkins']
  } 

  exec { 'replace security tag to false':
    command => '/bin/sed -i "s#<useSecurity>true#<useSecurity>false#g" /var/lib/jenkins/config.xml',
    require => Exec['add jenkins java variable'],
  } 

}
