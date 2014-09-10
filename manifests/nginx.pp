# == Class: devpi::nginx
#
# NginX configuration.
#
class devpi::nginx ($username, $dataroot, $port, $www_port) {
    $www_default_disable        = $devpi::www_default_disable

    if $www_default_disable {
        file { '/etc/nginx/sites-enabled/default':
            ensure      => absent,
            require     => [Package['nginx'],],
        }
    }

    file { '/etc/nginx/sites-available/devpi':
        ensure      => present,
        content     => template('devpi/nginx-devpi.conf'),
        owner       => 'root',
        group       => 'root',
        require     => [Package['nginx'],],
    }
    ->
    file { '/etc/nginx/sites-enabled/devpi':
        ensure      => link,
        target      => '../sites-available/devpi',
    }

    file { "${dataroot}/www":
        ensure      => directory,
        mode        => 0755,
        require     => [User[$username],],
    }
    ->
    file { "${dataroot}/www/favicon.ico":
        ensure      => present,
        source      => 'puppet:///modules/devpi/favicon.ico',
    }
}
