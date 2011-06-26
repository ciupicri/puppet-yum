class yum {
    include repos::media
    include repos::tmz-puppet
    include repos::ciupicri
    include cache

    case $operatingsystem {
        "CentOS": { include repos::epel5 }
        "Scientific": { include repos::epel6 }
    }
}
