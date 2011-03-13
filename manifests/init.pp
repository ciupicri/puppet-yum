class yum {
    include repos::media
    include repos::tmz-puppet
    include repos::ciupicri
    include cache
}
