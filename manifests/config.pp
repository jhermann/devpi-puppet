# == Class: devpi::config
#
class devpi::config {
    $username                   = $devpi::username
    $uid                        = $devpi::uid
    $port                       = $devpi::port
    $www_port                   = $devpi::www_port
    $www_scheme                 = $devpi::www_scheme
    $master_fqdn                = $devpi::master_fqdn
    $proxy                      = $devpi::proxy
    $no_proxy                   = $devpi::no_proxy

    # Dynamic/dependent defaults
    $userhome = $devpi::userhome ? {
      undef     => "/var/lib/${username}",
      default   => $devpi::userhome,
    }
    $dataroot = $devpi::dataroot ? {
      undef     => "${userhome}",
      default   => $devpi::dataroot,
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
    file { "${dataroot}/www":
        ensure      => directory,
        mode        => 0755,
        require     => [User[$username],],
    } ->
    file { "${dataroot}/www/templates":
        ensure      => directory,
        mode        => 0755,
    } ->
    file { "${dataroot}/www/static":
        ensure      => directory,
        owner       => 'www-data',
        mode        => 0755,
    } ->
    file { "${dataroot}/www/static/favicon.ico":
        ensure      => present,
        owner       => 'www-data',
        source      => 'puppet:///modules/devpi/favicon.ico',
    }
}
