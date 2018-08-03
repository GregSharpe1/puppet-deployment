node 'wordpress' {

class { 'jenkins': ; }

jenkins::plugin { 'git':
  version => '1.1.11',
}

}
