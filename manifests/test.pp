node 'jenkins' {
    file { '/home/vagrant/test.txt':
      ensure  => 'present',
  }
}
