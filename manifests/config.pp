# == Class: devpi::config
#
class devpi::config {
    $username                   = $devpi::username
    $uid                        = $devpi::uid
    $userhome                   = $devpi::userhome

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
        ensure      => 'present',
    } ->
    user { $username:
        ensure      => 'present',
        comment     => 'PyPI Proxy Server and Repository',
        gid         => $username,
        shell       => '/bin/bash',
        home        => $userhome,
        system      => true,
        managehome  => true,
    }
}
