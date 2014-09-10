#
# Example setup, this installs devpi-server on any machine when invoked
# via "sudo apply.sh".
#

node default {
    class { 'devpi':
        ensure              => 'latest',
        ensure_supervisor   => 'latest',
        ensure_nginx        => 'latest',
    }
}
