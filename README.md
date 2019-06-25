[![Travis](https://img.shields.io/travis/open-eid/linux-installer.svg)](https://travis-ci.org/open-eid/linux-installer)

Ubuntu metapackage
==================

A metapackage for Ubuntu/Debian based distributions.

1. Fetch the source

        git clone --recursive https://github.com/open-eid/linux-installer
        cd linux-installer

2. Build

        dh_make --createorig --addmissing --defaultless -y -p open-eid_18.6.0.0
        dch --distribution unstable -v 18.6.0.0 'Release'
        dpkg-buildpackage -rfakeroot -us -uc

3. Official packages can be installed via the helper script that configures your Debian based machine to use the official repository

        https://installer.id.ee/media/install-scripts/install-open-eid.sh

## Support
Official builds are provided through official distribution point [installer.id.ee](https://installer.id.ee). If you want support, you need to be using official builds. Contact our support via [www.id.ee](http://www.id.ee) for assistance.

Source code is provided on "as is" terms with no warranty (see license for more information). Do not file Github issues with generic support requests.
