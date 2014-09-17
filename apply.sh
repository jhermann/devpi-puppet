#! /bin/bash
#
# Puppet apply script (masterless), to be run under "root"!
# Designed for Debian-derived systems, tested on Ubuntu Trusty and Debian Wheezy.
#
# Check parameters in "site.pp".
#

set -e
basedir=$(cd $(dirname "$0") && pwd)
cd "$basedir"

fail() { echo "ERROR:" "$@"; exit 1; }

test $(id -u) -eq 0 || fail "Must be run as root!"
which puppet >/dev/null || apt-get install puppet
which facter >/dev/null || apt-get install facter

staging="/tmp/devpi-puppet-$$"
trap "rm -rf $staging || :" EXIT ERR TERM
mkdir "$staging"
ln -nfs "$basedir" "$staging/devpi"
puppet apply --modulepath "$staging" "$@" site.pp 2>&1 \
    | egrep -v '(Setting templatedir is deprecated|issue_deprecation_warning)'
