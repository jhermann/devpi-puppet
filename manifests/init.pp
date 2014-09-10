# == Class: devpi
#
# Module to install the "devpi" local PyPI proxy and repository.
#
# === Parameters
#
# [*ensure*]
# Passed to the devpi package.
# Defaults to present
#
# [*ensure_nginx*]
# Passed to the nginx package, unless undef, then the nginx package is not managed by this module.
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
    $ensure             = $devpi::params::ensure,
    $ensure_nginx       = $devpi::params::ensure_nginx,
    $proxy              = $devpi::params::proxy,
    $no_proxy           = $devpi::params::no_proxy,
    #$ = $devpi::params::,
) inherits devpi::params {
    #validate_string($…)
    #validate_re($::osfamily, '^(Debian|RedHat)$', 'This module only works on Debian and Red Hat based systems.')
    #validate_bool($…)

    class { 'devpi::install': } ->
    #class { 'devpi::config': } ~>
    #class { 'devpi::service': } ->
    Class['devpi']
}
