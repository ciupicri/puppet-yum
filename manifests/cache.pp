class yum::cache {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        default: { fail("Your operating system is unsupported") }
    }
}
