class yum::mediarepo::base {
    include yum::common

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
        descr            => "${operatingsystem} ${operatingsystemrelease} - ${architecture} media",
        baseurl          => "file:///mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD",
        enabled         => '1',
        gpgcheck        => '0',
        gpgkey          => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-fedora-$basearch',
        metadata_expire => '-1',
        cost            => '500',
        priority        => '1',
    }
}

class yum::mediarepo::centos inherits yum::mediarepo::base {
    Mount["/mnt/misc/${operatingsystem}-${operatingsystemrelease}-${architecture}-DVD"] {
        fstype => "nfs4",
    }
}

class yum::mediarepo {
    case $operatingsystem {
        "Fedora": { include base }
        "CentOS": { include centos }
        default: { fail("Your operating system is unsupported") }
    }
}
