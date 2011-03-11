class yumconfig::mediarepo {
    include yumconfig::common

    file { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD",
        fstype  => "nfs",
        options => "ro",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD"],
    }

    yumrepo { "media":
        descr            => 'Fedora $releasever - $basearch media',
        baseurl          => 'file:///mnt/misc/Fedora-$releasever-$basearch-DVD',
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch',
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}
