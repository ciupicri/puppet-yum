class yumconfig::ciupicrirepo {
    include yumconfig::common

    file { "/mnt/misc/${operatingsystem}-ciupicri-repo":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}-ciupicri-repo":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}-ciupicri-repo/${operatingsystemrelease}",
        fstype  => "nfs",
        options => "ro",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}-ciupicri-repo"],
    }

    yumrepo { "ciupicri":
        descr            => "ciupicri's repo for ${operatingsystem} $releasever",
        baseurl          => "file:///mnt/misc/${operatingsystem}-ciupicri-repo",
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => "file:///mnt/misc/${operatingsystem}-ciupicri-repo/RPM-GPG-KEY-ciupicri",
        metadata_expire => '0',
        cost            => '500',
        priority        => '1',
    }
}
