class yum::repos::media::el5 {
    yum::repos::media::base { "el-media-1of2":
        reposuffix => "-1of2",
        fstype     => "nfs4",
    }

    # broken repository
    #yum::repos::media::base { "el-media-2of2":
    #    reposuffix => "-2of2",
    #    fstype     => "nfs4",
    #}
}
