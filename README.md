# ![logo](https://raw.githubusercontent.com/jhermann/devpi-puppet/master/doc/static/logo-32.png) devpi-puppet

This is a Puppet module to install [devpi-server](http://doc.devpi.net/latest/) behind a NginX proxy.
See also [debianized-devpi](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi)
for building the required `devpi` package.
On non-Debian platforms, you can use [fpm](https://github.com/jordansissel/fpm) or similar tools to build such a package.


## Using the module

If you just want to install `devpi-server` on a single host, you can use the supplied
`apply.sh` shell script, which when called by `root` installs Puppet (if missing),
and then applies the node definition contained in `site.pp`.

All the possible parameters are documented in
[init.pp](https://github.com/jhermann/devpi-puppet/tree/master/manifests/init.pp),
for a HTML rendering see **TODO**.


## References

* [devpi Docs](http://doc.devpi.net/latest/)
* [devpi Debian packaging](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi)
* [Puppet](https://puppetlabs.com/puppet/puppet-open-source)
