# Setup of PyPI proxy server
# TODO: add real parameters
# TODO: split off nginx setup into its own class
define devpi::server ($uid='') {
    $username   = 'devpi'
    $homedir    = "/var/lib/${username}"
    $dataroot   = "$homedir"
    $port       = '3141'
    $www_port   = '31415'
    $proxy      = ''
    $no_proxy   = "${fqdn},lan,domain"

    File {
        owner       => $username,
        group       => $username,
        mode        => 0644,
    }

    # Install software
    package { 'devpi': ensure => 'latest' }
    package { 'nginx-full': ensure => 'latest' }

    # System user account
    group { $username:
        ensure      => 'present',
    }
    ->
    user { $username:
        ensure      => 'present',
        comment     => 'PyPI Proxy Server',
        uid         => $uid,
        gid         => $username,
        shell       => '/bin/bash',
        home        => $homedir,
        system      => true,
        managehome  => true,
    }

    # Data storage
    file { "${dataroot}":
        ensure      => directory,
        mode        => 0755,
        require     => [User[$username],],
    }
    ->
    file { "${dataroot}/data":
        ensure      => directory,
        mode        => 0755,
    }

    # NginX configuration
    file { '/etc/nginx/sites-enabled/default':
        ensure      => absent,
        require     => [Package['nginx-full'],],
    }
    ->
    file { '/etc/nginx/sites-available/devpi':
        ensure      => present,
        content     => template('devpi/nginx-devpi.conf'),
        owner       => 'root',
        group       => 'root',
        require     => [Package['nginx-full'],],
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

    exec { 'nginx reload devpi':
        command     => 'service nginx reload',
        subscribe   => File['/etc/nginx/sites-available/devpi'],
        refreshonly => true,
        provider    => shell,
        require     => [Package['nginx-full'], File['/etc/nginx/sites-enabled/devpi']],
    }

    # Supervisor configuration

    package { 'supervisor': ensure => 'latest' }
    file { "/etc/supervisor/conf.d/devpi-server.conf":
        ensure      => present,
        content     => template('devpi/supervisord.conf'),
        owner       => 'root',
        group       => 'root',
        require     => [Package['supervisor'],],
    }

    exec { 'supervisor update devpi-server':
        command     => 'supervisorctl update',
        subscribe   => File['/etc/supervisor/conf.d/devpi-server.conf'],
        refreshonly => true,
        provider    => shell,
        require     => [Package['devpi'], File["${dataroot}/data"]],
    }
    exec { 'supervisor restart devpi-server (devpi update)':
        command     => 'supervisorctl restart devpi-server',
        subscribe   => Package[devpi],
        refreshonly => true,
        provider    => shell,
        require     => [File["${dataroot}/data"], File['/etc/supervisor/conf.d/devpi-server.conf']],
    }
}
