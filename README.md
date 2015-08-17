Ubuntu metapackage
==================

A metapackage for Ubuntu/Debian based distributions.

1. Fetch the source

        git clone --recursive https://github.com/open-eid/linux-installer
        cd linux-installer

2. Build

        dh_make --createorig --addmissing --defaultless -y -p estonianidcard_3.11.0.0
        dch --distribution unstable -v 3.11.0.0 'Release'
        dpkg-buildpackage -rfakeroot -us -uc

## Support
Official builds are provided through official distribution point [installer.id.ee](https://installer.id.ee). If you want support, you need to be using official builds. Contact for assistance by email [abi@id.ee](mailto:abi@id.ee) or [www.id.ee](http://www.id.ee).

Source code is provided on "as is" terms with no warranty (see license for more information). Do not file Github issues with generic support requests.
