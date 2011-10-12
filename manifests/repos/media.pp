class yum::repos::media {
    case $operatingsystem {
        "Fedora": { yum::repos::media::base { "fedora": } }
        "CentOS": {
            case $operatingsystemrelease {
                "5.7": { include centos5 }
            }
        }
        "Scientific": { yum::repos::media::base { "scientific": } }
        default: { fail("Your operating system is unsupported") }
    }
}
