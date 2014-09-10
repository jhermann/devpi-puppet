# == Class: devpi::params
#
# Defaut parameter values for the "devpi" module.
#
class devpi::params {
    $username                   = 'devpi'
    $uid                        = undef
    $userhome                   = undef
    $dataroot                   = undef
    $ensure                     = present
    $ensure_nginx               = undef
    $ensure_supervisor          = undef
    $port                       = 3141
    $www_port                   = 31415
    $www_scheme                 = 'http'
    $master_fqdn                = undef
    $proxy                      = undef
    $no_proxy                   = "${fqdn},lan,domain"
}
