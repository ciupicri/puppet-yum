class yum::repos::media {
    case $operatingsystem {
        "Fedora": { yum::repos::media::base { "fedora": } }
        "CentOS": {
            case $operatingsystemrelease {
                "5.7": { include el5 }
                "6.0": { yum::repos::media::base { "centos": } }
            }
        }
        "Scientific": { yum::repos::media::base { "scientific": } }
        default: { fail("Your operating system is unsupported") }
    }
}
