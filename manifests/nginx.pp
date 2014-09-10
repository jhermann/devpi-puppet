# == Class: devpi::nginx
#
# Optional NginX proxy for an external port. See "devpi" for general parameters.
#
# === Parameters
#
# [*ensure*]
# Passed to the nginx package, unless undef, then the package is not managed by this module.
# Defaults to undef
#
# [*www_default_disable*]
# Disable 'default' NginX site?
# Defaults to false
#
class devpi::nginx (
    $ensure                     = $devpi::params::ensure_nginx,
    $www_default_disable        = $devpi::params::www_default_disable,
) inherits devpi::params {
    Class['devpi']
    -> class { 'devpi::nginx_config': }
    ~> class { 'devpi::nginx_service': }
    -> Class['devpi::nginx']
}
