class yum::repos::tmz-puppet::fedora {
    yumrepo { "tmz-puppet":
        descr    => 'Puppet for Fedora $releasever - $basearch',
        baseurl  => 'http://tmz.fedorapeople.org/repo/puppet/fedora/$releasever/$basearch',
        enabled  => '1',
        gpgcheck => '1',
        gpgkey   => 'http://tmz.fedorapeople.org/repo/RPM-GPG-KEY-tmz',
    }
}

class yum::repos::tmz-puppet::el {
    yumrepo { "tmz-puppet":
        descr            => 'Puppet for EL $releasever - $basearch',
        baseurl          => 'http://tmz.fedorapeople.org/repo/puppet/epel/$releasever/$basearch',
        enabled         => '1',
        gpgcheck        => '1',
        gpgkey          => 'http://tmz.fedorapeople.org/repo/RPM-GPG-KEY-tmz',
    }
}

class yum::repos::tmz-puppet {
    case $operatingsystem {
        "Fedora": { include fedora }
        "CentOS": { include el }
        default: { fail("Your operating system is unsupported") }
    }
}