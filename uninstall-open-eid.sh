#!/bin/bash
# This script removes open-eid .deb packages

sudo dpkg --purge \
  opensc opensc-pkcs11 awp \
  chrome-token-signing firefox-pkcs11-loader \
  libdigidoc-common libdigidoc-tools libdigidoc2 \
  libdigidocpp-common libdigidocpp-tools libdigidocpp1 \
  qdigidoc4 qdigidoc qesteidutil qdigidoc-tera open-eid
