class yum::cache::centos inherits yum::cache::base {
    Mount["/var/cache/yum"] {
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-yum-cache/${architecture}/${operatingsystemrelease}",
        fstype  => "nfs4",
    }

    Mount["/mnt/misc/yum-packages"] {
        fstype  => "nfs4",
    }
}
