class yum {
    Class {
        stage => "yum", # http://projects.puppetlabs.com/issues/8263#note-6
    }

    include repos::media
    include repos::tmz-puppet
    include repos::ciupicri
    include cache
    include repos::epel
}
