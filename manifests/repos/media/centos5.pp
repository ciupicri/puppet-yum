class yum::repos::media::centos5 {
    yum::repos::media::base { "centos-media-1of2": 
        reposuffix => "-1of2",
        fstype     => "nfs4",
    }

    # broken repository
    #yum::repos::media::base { "centos-media-2of2": 
    #    reposuffix => "-2of2",
    #    fstype     => "nfs4",
    #}
}
