# == Class: devpi::service
#
# Restart services after configuration changes.
#
class devpi::service {
    $www_port       = $devpi::www_port

    # Supervisor
    exec { 'supervisor update devpi-server':
        command     => 'supervisorctl update',
        subscribe   => File['/etc/supervisor/conf.d/devpi-server.conf'],
        refreshonly => true,
        provider    => shell,
        require     => [Package['devpi'], Package['supervisor'],],
    }
    exec { 'supervisor restart devpi-server (devpi update)':
        command     => 'supervisorctl restart devpi-server',
        subscribe   => Package['devpi'],
        refreshonly => true,
        provider    => shell,
        require     => [Package['supervisor'],],
    }
}
