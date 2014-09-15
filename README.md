# ![logo](https://raw.githubusercontent.com/jhermann/devpi-puppet/master/doc/static/logo-32.png) devpi-puppet

![Apache 2.0 licensed](http://img.shields.io/badge/license-Apache_2.0-red.svg)

**Table of Contents**

- [Overview](#user-content-overview)
- [TL;DR](#user-content-tldr)
- [Using the module in detail](#user-content-using-the-module-in-detail)
- [Tested platforms](#user-content-tested-platforms)
- [Related projects](#user-content-related-projects)
- [References](#user-content-references)


## Overview

This is a Puppet module to install [devpi-server](http://doc.devpi.net/latest/) behind a NginX proxy.
See also [debianized-devpi](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi)
for building the required `devpi` package.
On non-Debian platforms, you can use [fpm](https://github.com/jordansissel/fpm) or similar tools to build such a package.

| Screenshot of the 'default' theme |
|:-------------:|
| ![Screenshot of the 'default' theme](https://raw.githubusercontent.com/jhermann/devpi-puppet/master/doc/static/theme-default.png) |


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

### Parameters

All the possible parameters are documented in
[init.pp](https://github.com/jhermann/devpi-puppet/tree/master/manifests/init.pp),
for a HTML rendering see **TODO**.

### Importing the module into your project

If for whatever reason you don't want to use tools like
the [puppet module](https://docs.puppetlabs.com/puppet/latest/reference/modules_installing.html) command
or [librarian-puppet](http://librarian-puppet.com/),
the following shows how to use `git subtree` (as opposed to `git submodule`)
to import this repository into your `modules` directory.

First, and once only, add `devpi-puppet` to your remotes and add a subtree named `modules/devpi`:

```sh
git remote add -f devpi-puppet "https://github.com/jhermann/devpi-puppet.git"
git remote update && git subtree add --prefix modules/devpi devpi-puppet master --squash
```

Then to later update the subtree, use this:

```sh
git remote update && git subtree pull --prefix modules/devpi devpi-puppet master --squash
```

You can also use a tag name instead of `master`, to get a specific release.


## Tested platforms

This module is known to work on:

* Debian 7.6 (wheezy)
* Ubuntu 12.04 (precise)
* Ubuntu 14.04 (trusty)


## Related projects

* [devpi](https://bitbucket.org/hpk42/devpi) – The main project on Bitbucket.
* [devpi Debian packaging](https://github.com/jhermann/devpi-enterprisey/tree/master/debianized-devpi) – Build a DEB package for `devpi` that contains all dependencies and extensions in a virtualenv.
* [puppet-module-skeleton](https://github.com/garethr/puppet-module-skeleton) – A great stencil for Puppet modules.
* [daniellawrence/puppet-devpi](https://github.com/daniellawrence/puppet-devpi) – An alternative `devpi` Puppet module.
* [dave-shawley/devpi-cookbook](https://github.com/dave-shawley/devpi-cookbook) – Chef cookbook for `devpi-server`.
* [scrapinghub/docker-devpi](https://github.com/scrapinghub/docker-devpi) – Trusted build of `devpi` published to the public Docker registry.
* [daniellawrence/devpi-docker](https://github.com/daniellawrence/devpi-docker) – Running `devpi` the easy way.
* [fschulze/devpi-buildout](https://github.com/fschulze/devpi-buildout) – A buildout to set up `devpi-server` on localhost.


## References

* [devpi Docs](http://doc.devpi.net/latest/)
* [Puppet Homepage](https://puppetlabs.com/puppet/puppet-open-source)
