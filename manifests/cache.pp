class yum::cache {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": {
            case $operatingsystemrelease {
                "5.7": { include centos5 }
                "6.0": { include base }
            }
        }
        "Scientific": { include base }
        default: { fail("Your operating system is unsupported") }
    }
}
