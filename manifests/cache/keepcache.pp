class yum::cache::keepcache {
    augeas { "yum":
        context => "/files/etc/yum.conf/main",
        changes => "set keepcache 1",
    }
}
