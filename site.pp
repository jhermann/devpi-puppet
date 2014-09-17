#
# Example setup, this installs devpi-server on any machine when invoked
# via "sudo apply.sh".
#

class themed_devpi_with_nginx ($theme='default', $listen=undef) {
    class { 'devpi':
        ensure              => 'latest',
        ensure_supervisor   => 'latest',
        theme               => "devpi/themes/$theme",
    }

    # to disable the NginX proxy, comment this out
    class { 'devpi::nginx':
        ensure              => 'latest',
        www_default_disable => true,
        listen              => $listen
    }
}


node /lxujhe.*/ {
    $eth0_name = inline_template("<% _erbout.concat(Resolv::DNS.open.getname('$ipaddress_eth0').to_s) %>")

    class { 'themed_devpi_with_nginx':
        listen              => ["${eth0_name}:31415", "${eth0_name}:31443 ssl"],
        theme               => 'mam'
    }
}

node default {
    class { 'themed_devpi_with_nginx': }
}
