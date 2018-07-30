node 'agent' {
  class { 'apache':  
    mpm_module => 'prefork'
  }
}
