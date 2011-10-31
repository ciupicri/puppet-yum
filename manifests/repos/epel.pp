class yum::repos::epel {
    case $operatingsystem {
        "CentOS": { include epel5 }
        "Scientific": { include epel6 }
    }
}

