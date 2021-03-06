class yum::repos::ciupicri::base {
    include yum::common

    file { "/mnt/misc/${operatingsystem}-ciupicri-repo":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}-ciupicri-repo":
        device  => "${yum_nfs_server}:/${operatingsystem}-ciupicri-repo/${operatingsystemrelease}",
        fstype  => "nfs",
        options => "ro,intr,rsize=1048576,wsize=1048576",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}-ciupicri-repo"],
    }

    yumrepo { "ciupicri":
        descr            => "ciupicri's repo for ${operatingsystem} $releasever",
        baseurl          => "file:///mnt/misc/${operatingsystem}-ciupicri-repo",
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => "file:///mnt/misc/${operatingsystem}-ciupicri-repo/RPM-GPG-KEY-Tabacioc",
        metadata_expire => '0',
        cost            => '500',
        priority        => '1',
    }
}

class yum::repos::ciupicri::centos inherits yum::repos::ciupicri::base {
    Mount["/mnt/misc/${operatingsystem}-ciupicri-repo"] {
        fstype => "nfs4",
    }
}

class yum::repos::ciupicri {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        "Scientific": { include base }
        default: { fail("Your operating system is unsupported") }
    }
}
