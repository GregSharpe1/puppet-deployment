node 'jenkins' {
  # We have decided to attempt to create the manifest ourselves

  # According to the installion docs from Jenkins.io 
  # https://jenkins.io/doc/book/installing/

  # First step is to add the gpg key to the list of trusted keys
  include apt

  apt::key{ 'jenkins-ci':
    server => 'https://pkg.jenkins.io/debian/jenkins.io.key'
  }

  # exec { 'added jenkins apt key':
  #   command => "wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -"    
  # }

  apt::source { 'jenkins_ci':
    comment => "Adding the Jenkins-ci source",
    location => "http://pkg.jenkins.io/debain-stable"
    # release => "stable"
    include => {
      'deb' => true,
    },
  }

  # exec { 'deb to apt jenkins.list': 
  #   command => sudo sh -c ' echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
  # }

  package { 'jenkins':
    name => 'jenkins'
    ensure => installed,
    require => Exec['apt-get update']
  }
}
