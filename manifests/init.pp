class yumconfig::common {
    file { "/mnt/misc":
        ensure => directory,
    }
}

class yumconfig::mediarepo {
    include yumconfig::common

    file { "/mnt/misc/${operatingsystem}${operatingsystemrelease}-${architecture}-DVD":
        ensure  => directory,
        require => File["/mnt/misc"],
    }

    mount { "/mnt/misc/${operatingsystem}${operatingsystemrelease}-${architecture}-DVD":
        device  => "hermes.lizeanunet.tld:/${operatingsystem}${operatingsystemrelease}-${architecture}-DVD",
        fstype  => "nfs",
        options => "ro",
        ensure  => mounted,
        require => File["/mnt/misc/${operatingsystem}${operatingsystemrelease}-${architecture}-DVD"],
    }

    yumrepo { "media":
        descr            => 'Fedora $releasever - $basearch media',
        baseurl          => 'file:///mnt/misc/Fedora$releasever-$basearch-DVD',
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch',
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}

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
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}

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
