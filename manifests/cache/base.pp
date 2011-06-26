class yum::cache::base {
    include yum::common
    include yum::cache::keepcache

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
        device  => "${yum_nfs_server}:/${operatingsystem}-yum-packages/${operatingsystemrelease}",
        fstype  => "nfs",
        options => "rw",
        ensure  => mounted,
        require => File["/mnt/misc/yum-packages"],
    }
}
