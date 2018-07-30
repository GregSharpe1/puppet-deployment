node 'jenkins' {
  include jenkins
  include java

  # Java install
  java::oracle { 'jdk8' :
    ensure  => 'present',
    version => '8',
    java_se => 'jdk',
  }
}
