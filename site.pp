#
# Example setup, this installs devpi-server on any machine when invoked
# via "sudo apply.sh".
#

node default {
    include devpi
    devpi::server { 'devpi': }
}
