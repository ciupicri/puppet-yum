class yum::repos::media::base {
    include yum::common

    file { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD":
        device  => "${yum_nfs_server}:/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD",
        fstype  => "nfs",
        options => "ro,intr,rsize=1048576,wsize=1048576",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD"],
    }

    yumrepo { "media":
        descr           => "${operatingsystem} ${operatingsystemrelease} - ${architecture} media",
        baseurl         => "file:///mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD",
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch',
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}

class yum::repos::media::centos inherits yum::repos::media::base {
    Mount["/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD"] {
        fstype => "nfs4",
    }
}

class yum::repos::media {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        "Scientific": { include base }
        default: { fail("Your operating system is unsupported") }
    }
}
