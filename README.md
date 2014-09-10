# ![logo](https://raw.githubusercontent.com/jhermann/devpi-puppet/master/doc/static/logo-32.png) devpi-puppet

This is a Puppet module to install [devpi-server](http://doc.devpi.net/latest/) behind a NginX proxy.
See also [debianized-devpi](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi)
for building the required `devpi` package.
On non-Debian platforms, you can use [fpm](https://github.com/jordansissel/fpm) or similar tools to build such a package.


## TL;DR

If you just want a working 'devpi-server' on your machine proxied by NginX on port 31415
and watched by `supervisord`, then call these commands, after either installing
the `devpi` package via `dpkg -i`, or providing it in a source registered with APT:

```sh
git clone "https://github.com/jhermann/devpi-puppet.git"
cd devpi-puppet
sudo ./apply.sh
```

You can also pass `--noop` and other Puppet options to the script.
It installs Puppet if that's missing, and then applies the node definition contained in `site.pp`.


## Using the module in detail

All the possible parameters are documented in
[init.pp](https://github.com/jhermann/devpi-puppet/tree/master/manifests/init.pp),
for a HTML rendering see **TODO**.


## Tested platforms

This module is known to work on:

* Debian 7.6 (wheezy)
* Ubuntu 12.04 (precise)
* Ubuntu 14.04 (trusty)


## References

* [devpi Docs](http://doc.devpi.net/latest/)
* [devpi Debian packaging](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi)
* [Puppet](https://puppetlabs.com/puppet/puppet-open-source)
* [puppet-module-skeleton](https://github.com/garethr/puppet-module-skeleton)
