#
# Example setup, this installs devpi-server on any machine when invoked
# via "sudo apply.sh".
#

class themed_devpi_with_nginx ($theme='default') {
    class { 'devpi':
        ensure              => 'latest',
        ensure_supervisor   => 'latest',
        theme               => "devpi/themes/$theme",
    }

    # to disable the NginX proxy, comment this out
    class { 'devpi::nginx': ensure => 'latest', www_default_disable => true }
}


node /lxujhe.*/ {
    class { 'themed_devpi_with_nginx': theme => 'mam' }
}

node default {
    class { 'themed_devpi_with_nginx': }
}
