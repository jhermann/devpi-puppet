# == Class: devpi::nginx
#
# Optional NginX proxy for an external port. See "devpi" for general parameters.
#
# === Parameters
#
# [*ensure*]
# Passed to the nginx package, unless undef, then the package is not managed by this module.
# Defaults to undef.
#
# [*www_default_disable*]
# Disable 'default' NginX site?
# Defaults to false.
#
# [*listen*]
# Array of interfaces (IPs, domain names) to listen on.
# See http://nginx.org/en/docs/http/ngx_http_core_module.html#listen for details.
# Defaults to undef, which means to listen to `www_port` (on all interfaces).
#
class devpi::nginx (
    $ensure                     = $devpi::params::ensure_nginx,
    $www_default_disable        = $devpi::params::www_default_disable,
    $listen                     = $devpi::params::listen,
) inherits devpi::params {
    Class['devpi']
    -> class { 'devpi::nginx_config': }
    ~> class { 'devpi::nginx_service': }
    -> Class['devpi::nginx']
}
