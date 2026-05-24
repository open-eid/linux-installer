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

## Arch Linux (community-supported)

The helper script also supports Arch Linux and Arch-family derivatives
(Manjaro, EndeavourOS, CachyOS, Garuda). When run on those systems it
installs the Estonian eID stack via `pacman` and an AUR helper
(`yay`, `paru`, `pikaur` or `trizen` — whichever is available):

- **pacman:** `opensc`, `pcsclite`, `ccid`, `pcsc-tools`
- **AUR:** `qdigidoc4`, `web-eid-native`, `web-eid-chrome`, `web-eid-firefox`

The `pcscd.socket` smartcard daemon is enabled, and the OpenSC PKCS#11
module is available at `/usr/lib/opensc-pkcs11.so` for Firefox; the
Chrome / Chromium / Edge native messaging host is registered
automatically.

This path uses community-maintained AUR packages and is not part of the
officially supported distributions listed at
[id.ee](https://www.id.ee/en/article/install-id-software/).

## Support
Official builds are provided through official distribution point [id.ee](https://www.id.ee/en/article/install-id-software/). If you want support, you need to be using official builds. Contact our support via [www.id.ee](http://www.id.ee) for assistance.

Source code is provided on "as is" terms with no warranty (see license for more information). Do not file Github issues with generic support requests.
