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
    $ssl_port                   = 31443
    $ssl_cert                   = undef
    $www_default_disable        = false
    $theme                      = undef
    $master_fqdn                = undef
    $master_scheme              = 'https'
    $master_addr                = undef
    $proxy                      = undef
    $ssl_proxy                  = undef
    $no_proxy                   = "${fqdn},lan,domain"
    $listen                     = undef
    $immutable_accounts         = false
}
