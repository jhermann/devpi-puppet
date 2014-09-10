# == Class: devpi::config
#
class devpi::config {
    $username                   = $devpi::username
    $uid                        = $devpi::uid

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
}
