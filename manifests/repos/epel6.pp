class yum::repos::epel6 {
    yumrepo { 'epel':
        descr       => 'Extra Packages for Enterprise Linux 6 - $basearch',
        mirrorlist  => 'https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch',
        enabled     => '1',
        gpgcheck    => '1',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6':
        owner  => "root",
        group  => "root",
        mode   => "0644",
        source => "puppet:///modules/${caller_module_name}/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6",
    }
}
