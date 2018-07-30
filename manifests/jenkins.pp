node 'jenkins' {
  class {'jenkins' :
    install_java => true,
    cli => true
  }
}
