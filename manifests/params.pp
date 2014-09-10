# == Class: devpi::params
#
# Defaut parameter values for the "devpi" module.
#
class devpi::params {
    $username                   = 'devpi'
    $uid                        = undef
    $userhome                   = "/var/lib/${username}"
    $ensure                     = present
    $ensure_nginx               = undef
    $ensure_supervisor          = undef
    $proxy                      = undef
    $no_proxy                   = "${fqdn},lan,domain"
}
