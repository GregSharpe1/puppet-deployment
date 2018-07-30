node 'jenkins' {
  include jenkins

  class { 'java' :
    package => 'java-1.8.0-openjdk-devel',
  }

  # Java install
  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }
}
