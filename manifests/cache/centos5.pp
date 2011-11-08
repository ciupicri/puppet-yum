class yum::cache::centos inherits yum::cache::base {
    Mount["/var/cache/yum"] {
        device  => "${yum_nfs_server}:/${operatingsystem}-yum-cache/${architecture}/${operatingsystemrelease}",
        fstype  => "nfs4",
    }

    Mount["/mnt/misc/yum-packages"] {
        fstype  => "nfs4",
    }
}
