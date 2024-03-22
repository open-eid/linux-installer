[![Build Status](https://github.com/open-eid/linux-installer/workflows/CI/badge.svg?branch=master)](https://github.com/open-eid/linux-installer/actions)

Ubuntu metapackage
==================

A metapackage for Ubuntu/Debian based distributions.

1. Fetch the source

        git clone --recursive https://github.com/open-eid/linux-installer
        cd linux-installer

2. Build

        dch --distribution unstable -v 18.6.0.0 'Release'
        dpkg-buildpackage -rfakeroot -us -uc

3. Official packages can be installed via the helper script that configures your Debian based machine to use the official repository

        https://installer.id.ee/media/install-scripts/install-open-eid.sh

## Support
Official builds are provided through official distribution point [id.ee](https://www.id.ee/en/article/install-id-software/). If you want support, you need to be using official builds. Contact our support via [www.id.ee](http://www.id.ee) for assistance.

Source code is provided on "as is" terms with no warranty (see license for more information). Do not file Github issues with generic support requests.
