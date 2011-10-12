define yum::repos::media::base ($reposuffix = '', $fstype = 'nfs') {
    include yum::common

    file { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD${reposuffix}":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD${reposuffix}":
        device  => "${yum_nfs_server}:/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD${reposuffix}",
        fstype  => "${fstype}",
        options => "ro,intr,rsize=1048576,wsize=1048576",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD${reposuffix}"],
    }

    yumrepo { "media${reposuffix}":
        descr           => "${operatingsystem} ${operatingsystemrelease} - ${architecture} media${reposuffix}",
        baseurl         => "file:///mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD${reposuffix}",
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch',
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}
