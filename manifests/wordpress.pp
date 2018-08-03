node 'wordpress' {

class { 'jenkins': ; }

install-jenkins-plugin {
    "git-plugin" :
        name    => "git,
        version => "1.1.11";
}
}
