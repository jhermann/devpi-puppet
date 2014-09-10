# == Class: devpi::nginx_service
#
# Restart NginX after configuration changes.
#
class devpi::nginx_service {
    exec { 'nginx reload devpi':
        command     => 'service nginx reload',
        subscribe   => File['/etc/nginx/sites-available/devpi'],
        refreshonly => true,
        provider    => shell,
        require     => [Package['nginx'], File['/etc/nginx/sites-enabled/devpi']],
    }
}
