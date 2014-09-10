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

staging="/tmp/devpi-puppet-$$"
trap "rm -rf $staging || :" EXIT ERR TERM
mkdir "$staging"
ln -nfs "$basedir" "$staging/devpi"
puppet apply --modulepath "$staging" "$@" site.pp
