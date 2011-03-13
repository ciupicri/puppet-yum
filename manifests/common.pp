class yum::common {
    file { "/mnt/misc":
        ensure => directory,
    }
}
