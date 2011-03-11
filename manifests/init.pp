class yumconfig::yumcache {
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

class yumconfig {
    include mediarepo
    include ciupicrirepo
    include yumcache
}
