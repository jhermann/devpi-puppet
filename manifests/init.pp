# == Class: devpi
#
# Module to install the "devpi" local PyPI proxy and repository.
#
# === Parameters
#
# [*username*]
# Name of the system account used to run 'devpi-server'.
# Defaults to 'devpi'
#
# [*uid*]
# If set, fixed user ID to use for the `username` account.
# Defaults to undef
#
# [*userhome*]
# Home directory of the `username` account.
# Defaults to undef, which means "/var/lib/${username}"
#
# [*dataroot*]
# Root directory of data store and backup.
# Defaults to undef, which means "${userhome}"
#
# [*ensure*]
# Passed to the devpi package.
# Defaults to present
#
# [*ensure_supervisor*]
# Passed to the supervisor package, unless undef, then the package is not managed by this module.
# Defaults to undef
#
# [*port*]
# Port for internal HTTP service endpoint (bound to localhost).
# Defaults to 3141
#
# [*www_port*]
# Port for external HTTP[S] service endpoint; this is only used when the optional
# devpi::nginx class is added to your node.
# Defaults to 31415
#
# [*www_scheme*]
# Protocol scheme for external HTTP[S] service endpoint.
# Defaults to 'http'
#
# [*theme*]
# Set to a Puppet module folder tree with a devpi theme, e.g. 'devpi/themes/default'.
# See http://doc.devpi.net/latest/web.html#themes for more.
# Defaults to undef
#
# [*master_fqdn*]
# If set, this is the FQDN of the master host (everything else is a replica). Note that
# for replication, you need to add the optional devpi::nginx class to your master node.
#
# [*master_addr*]
# If set, this is the HTTP[S] host name or IP to use for replication; otherwise,
# the `master_fqdn` value is used.
# Defaults to undef, which means the same as `master_fqdn`
#
# [*proxy*]
# If set, runs "devpi-server" with this HTTP[S] proxy activated.
#
# [*ssl_proxy*]
# If set, runs "devpi-server" with this HTTPS proxy activated.
# Defaults to undef, which means to replicate the `proxy` parameter
#
# [*no_proxy*]
# Domains to exclude from going through an active HTTP[S] proxy.
# Defaults to the installation node, and local domains "lan" and "domain"
#

class devpi (
    $username                   = $devpi::params::username,
    $uid                        = $devpi::params::uid,
    $userhome                   = $devpi::params::userhome,
    $dataroot                   = $devpi::params::dataroot,
    $ensure                     = $devpi::params::ensure,
    $ensure_supervisor          = $devpi::params::ensure_supervisor,
    $port                       = $devpi::params::port,
    $www_port                   = $devpi::params::www_port,
    $www_scheme                 = $devpi::params::www_scheme,
    $theme                      = $devpi::params::theme,
    $master_fqdn                = $devpi::params::master_fqdn,
    $master_addr                = $devpi::params::master_addr,
    $proxy                      = $devpi::params::proxy,
    $ssl_proxy                  = $devpi::params::ssl_proxy,
    $no_proxy                   = $devpi::params::no_proxy,
) inherits devpi::params {
    #validate_string($…)
    #validate_re($::osfamily, '^(Debian|RedHat)$', 'This module only works on Debian and Red Hat based systems.')
    #validate_bool($…)

    class { 'devpi::install': }
    -> class { 'devpi::config': }
    ~> class { 'devpi::service': }
    -> Class['devpi']
}
