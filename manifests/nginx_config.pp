# == Class: devpi::nginx_config
#
# NginX configuration.
#
class devpi::nginx_config {
    # Variables used locally and by the 'nginx-devpi.conf' template
    $username           = $devpi::config::username
    $dataroot           = $devpi::config::dataroot
    $port               = $devpi::config::port
    $www_port           = $devpi::config::www_port
    $ssl_port           = $devpi::config::ssl_port
    $www_scheme         = $devpi::config::www_scheme
    $listen             = $devpi::nginx::listen
    $ssl_cert           = $devpi::nginx::ssl_cert
    $immutable_accounts = $devpi::nginx::immutable_accounts

    File {
        owner       => 'www-data',
        group       => $username,
        mode        => 0644,
    }

    if $devpi::nginx::ensure {
        package { 'nginx': ensure => $devpi::nginx::ensure, name => 'nginx-full' }
    }

    if $devpi::nginx::www_default_disable {
        file { '/etc/nginx/sites-enabled/default':
            ensure      => absent,
            require     => [Package['nginx'],],
        }
    }

    if $ssl_cert {
        file { '/etc/nginx/ssl':
            ensure      => directory,
            owner       => 'root',
            group       => 'root',
            mode        => 0750,
            require     => [Package['nginx'],],
        }
        # Must be provided manually or by the node using this module:
        -> File["/etc/nginx/ssl/${ssl_cert}.crt"]
        -> File["/etc/nginx/ssl/${ssl_cert}.key"]
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
}
