# == Class: devpi::params
#
# Defaut parameter values for the "devpi" module.
#
class devpi::params {
    $ensure                     = present
    $ensure_nginx               = undef
    $ensure_supervisor          = undef
    $proxy                      = undef
    $no_proxy                   = "${fqdn},lan,domain"
}
