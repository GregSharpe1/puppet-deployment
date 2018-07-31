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


  apt::key{ 'jenkins-ci':
    server => 'https://pkg.jenkins.io/debian/jenkins.io.key'
  }

  # exec { 'added jenkins apt key':
  #   command => "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -"    
  # }

  apt::source { 'jenkins-ci':
    comment => "Adding the Jenkins-ci package",
    location => "http://pkg.jenkins.io/debain-stable",
    repos => "binary",
    include => {
      'deb' => true,
    },
  }

  # # exec { 'deb to apt jenkins.list': 
  # #   command => sudo sh -c ' echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  # # }

  package { 'jenkins':
    name => 'jenkins',
    ensure => installed,
    require => Exec['apt-get update'],
  }
}
