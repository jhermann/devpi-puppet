# == Class: devpi::config
#
class devpi::config {
    $username                   = $devpi::username
    $uid                        = $devpi::uid
    $port                       = $devpi::port
    $www_port                   = $devpi::www_port
    $ssl_port                   = $devpi::ssl_port
    $ssl_cert                   = $devpi::ssl_cert
    $theme                      = $devpi::theme
    $master_fqdn                = $devpi::master_fqdn
    $master_scheme              = $devpi::master_scheme
    $proxy                      = $devpi::proxy
    $no_proxy                   = $devpi::no_proxy

    # Dynamic/dependent defaults
    $userhome = $devpi::userhome ? {
        undef       => "/var/lib/${username}",
        default     => $devpi::userhome,
    }
    $dataroot = $devpi::dataroot ? {
        undef       => $userhome,
        default     => $devpi::dataroot,
    }
    $master_addr = $devpi::master_addr ? {
        undef       => $master_fqdn,
        default     => $devpi::master_addr,
    }
    $master_port = $master_scheme ? {
        'http'      => $www_port,
        'https'     => $ssl_port,
        default     => fail("Unsupported master scheme '${master_scheme}'"),
    }
    $ssl_proxy = $devpi::ssl_proxy ? {
        undef       => $proxy,
        default     => $devpi::ssl_proxy,
    }

    # Resource defaults
    if $uid {
        User {
            uid     => $uid,
        }
    }
    File {
        owner       => $username,
        group       => $username,
        mode        => 0644,
    }

    # System user account & group
    group { $username:
        ensure      => present,
    } ->
    user { $username:
        ensure      => present,
        comment     => 'PyPI Proxy Server and Repository',
        gid         => $username,
        shell       => '/bin/bash',
        home        => $userhome,
        system      => true,
        managehome  => true,
    }

    # Data storage
    file { "${dataroot}":
        ensure      => directory,
        mode        => 0755,
        require     => [User[$username],],
    } ->
    file { "${dataroot}/data":
        ensure      => directory,
        mode        => 0755,
    }

    # Supervisor configuration
    file { '/etc/supervisor/conf.d/devpi-server.conf':
        ensure      => present,
        content     => template('devpi/supervisord.conf'),
        owner       => 'root',
        group       => 'root',
        require     => [Package['supervisor'],],
    }

    # Theming / WWW
    if $theme {
        file { "${dataroot}/www":
            ensure      => directory,
            source      => "puppet:///modules/${theme}",
            mode        => 0755,
            recurse     => true,
            require     => [User[$username],],
        }
    } else {
        file { "${dataroot}/www":
            ensure      => directory,
            mode        => 0755,
            require     => [User[$username],],
        }
    }

    # Default favicon
    file { "${dataroot}/www/favicon.ico":
        ensure      => present,
        owner       => 'www-data',
        source      => 'puppet:///modules/devpi/favicon.ico',
    }
}
