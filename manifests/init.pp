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
# Defaults to "/var/lib/${username}"
#
# [*ensure*]
# Passed to the devpi package.
# Defaults to present
#
# [*ensure_nginx*]
# Passed to the nginx package, unless undef, then the package is not managed by this module.
# Defaults to undef
#
# [*ensure_supervisor*]
# Passed to the supervisor package, unless undef, then the package is not managed by this module.
# Defaults to undef
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
    $ensure                     = $devpi::params::ensure,
    $ensure_nginx               = $devpi::params::ensure_nginx,
    $ensure_supervisor          = $devpi::params::ensure_supervisor,
    $proxy                      = $devpi::params::proxy,
    $no_proxy                   = $devpi::params::no_proxy,
    #$ = $devpi::params::,
) inherits devpi::params {
    #validate_string($…)
    #validate_re($::osfamily, '^(Debian|RedHat)$', 'This module only works on Debian and Red Hat based systems.')
    #validate_bool($…)

    class { 'devpi::install': } ->
    class { 'devpi::config': } ~>
    #class { 'devpi::service': } ->
    Class['devpi']
}
