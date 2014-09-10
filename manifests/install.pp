# == Class: devpi::install
#
# Module to install a pre-packaged distribution of "devpi".
#
# To build one for Debian-derived systems, see
#   https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi
#
# Otherwise, consider using "fpm" or a similar tool.
#
class devpi::install {
    package { 'devpi': ensure => $devpi::ensure }
    if $devpi::ensure_supervisor {
        package { 'supervisor': ensure => $devpi::ensure_supervisor }
    }
}
