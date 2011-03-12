class yumconfig::yumcache::base {
    include yumconfig::common

    mount { "/var/cache/yum":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-yum-cache",
        fstype  => "nfs",
        options => "rw",
        ensure  => mounted,
    }

    file { "/mnt/misc/yum-packages":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/yum-packages":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-yum-packages/${operatingsystemrelease}",
        fstype  => "nfs",
        options => "rw",
        ensure  => mounted,
        require => File["/mnt/misc/yum-packages"],
    }

    augeas { "yum":
        context => "/files/etc/yum.conf/main",
        changes => "set keepcache 1",
    }
}

class yumconfig::yumcache::centos inherits yumconfig::yumcache::base {
    Mount["/var/cache/yum"] {
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-yum-cache/${architecture}/${operatingsystemrelease}",
        fstype  => "nfs4",
    }

    Mount["/mnt/misc/yum-packages"] {
        fstype  => "nfs4",
    }
}

class yumconfig::yumcache {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        default: { fail("Your operating system is unsupported") }
    }
}
