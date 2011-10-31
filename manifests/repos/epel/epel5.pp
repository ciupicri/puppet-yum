class yum::repos::epel::epel5 {
    yumrepo { 'epel':
        descr       => 'Extra Packages for Enterprise Linux 5 - $basearch',
        mirrorlist  => 'http://mirrors.fedoraproject.org/mirrorlist?repo=epel-5&arch=$basearch',
        enabled     => '1',
        gpgcheck    => '1',
        gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL':
        owner  => "root",
        group  => "root",
        mode   => "0644",
        source => "puppet:///modules/${caller_module_name}/etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL",
    }
}
