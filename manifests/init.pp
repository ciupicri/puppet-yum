class yum {
    anchor { 'yum::begin': }
    anchor { 'yum::end': }

    class { 'repos::media':
        require => Anchor['yum::begin'],
        before  => Anchor['yum::end'],
    }
    class { 'repos::tmz-puppet':
        require => Anchor['yum::begin'],
        before  => Anchor['yum::end'],
    }
    class { 'repos::ciupicri':
        require => Anchor['yum::begin'],
        before  => Anchor['yum::end'],
    }
    class { 'cache':
        require => Anchor['yum::begin'],
        before  => Anchor['yum::end'],
    }

    case $operatingsystem {
        "CentOS": {
            class { 'repos::epel5':
                require => Anchor['yum::begin'],
                before  => Anchor['yum::end'],
            }
        }
        "Scientific": {
            class { 'repos::epel6':
                require => Anchor['yum::begin'],
                before  => Anchor['yum::end'],
            }
        }
    }
}
