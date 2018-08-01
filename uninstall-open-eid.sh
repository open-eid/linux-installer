#!/bin/bash
# This script removes open-eid .deb packages

sudo dpkg --purge \
  chrome-token-signing firefox-pkcs11-loader \
  libdigidoc-common libdigidoc-tools libdigidoc2 \
  libdigidocpp-common libdigidocpp-tools libdigidocpp1 \
  qdigidoc4 qdigidoc qesteidutil qdigidoc-tera opensc opensc-pkcs11 open-eid
