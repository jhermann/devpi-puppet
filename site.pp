#
# Example setup, this installs devpi-server on any machine when invoked
# via "sudo apply.sh".
#

class themed_devpi_with_nginx ($theme='default', $listen=undef, $ssl_cert=undef, $immutable_accounts=false) {
    class { 'devpi':
        ensure              => 'latest',
        ensure_supervisor   => 'latest',
        theme               => "devpi/themes/$theme",
    }

    # to disable the NginX proxy, comment this out
    class { 'devpi::nginx':
        ensure              => 'latest',
        www_default_disable => true,
        listen              => $listen,
        ssl_cert            => $ssl_cert,
        immutable_accounts  => $immutable_accounts,
    }
}


node /lxujhe.*/ {
    $eth0_name = inline_template("<%= Resolv::DNS.open.getname('$::ipaddress_eth0') %>")

    File['/etc/nginx/ssl'] ->
    file { "/etc/nginx/ssl/${::fqdn}.crt": ensure => present } ->
    file { "/etc/nginx/ssl/${::fqdn}.key": ensure => present }

    class { 'themed_devpi_with_nginx':
        ssl_cert            => $::fqdn,
        listen              => ["${eth0_name}:31415", "${eth0_name}:31443 ssl"],
        theme               => 'mam',
        immutable_accounts  => true,
    }
}

node default {
    class { 'themed_devpi_with_nginx': }
}
