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
# [*theming*]
# Activate devpi theming support?
# Defaults to true
#
# [*master_fqdn*]
# If set, this is the FQDN of the master (everything else is a replica). Note that
# for replication, you need to add the optional devpi::nginx class to your master node.
#
# [*proxy*]
# If set, runs "devpi-server" with this HTTP[S] proxy activated.
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
    $proxy                      = $devpi::params::proxy,
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
