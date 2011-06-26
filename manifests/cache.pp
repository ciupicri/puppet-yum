class yum::cache {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        "Scientific": { include base }
        default: { fail("Your operating system is unsupported") }
    }
}
