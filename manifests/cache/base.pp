class yum::cache::base {
    include yum::common
    include yum::cache::keepcache

    mount { "/var/cache/yum":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-yum-cache",
        fstype  => "nfs",
        options => "rw,intr,rsize=1048576,wsize=1048576",
        ensure  => mounted,
    }

    file { "/mnt/misc/yum-packages":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/yum-packages":
        device  => "${yum_nfs_server}:/${operatingsystem}-yum-packages/${operatingsystemrelease}",
        fstype  => "nfs",
        options => "rw,intr,rsize=1048576,wsize=1048576",
        ensure  => mounted,
        require => File["/mnt/misc/yum-packages"],
    }
}
