#!/bin/bash
# This script removes open-eid .deb packages

sudo dpkg --purge \
  opensc opensc-pkcs11 awp \
  chrome-token-signing chrome-token-signing-policy firefox-pkcs11-loader \
  token-signing-native token-signing-chrome token-signing-firefox \
  libdigidoc-common libdigidoc-tools libdigidoc2 \
  libdigidocpp-common libdigidocpp-tools libdigidocpp1 \
  qdigidoc4 qdigidoc qesteidutil qdigidoc-tera open-eid
sudo rm /etc/apt/sources.list.d/ria-repository.list
sudo apt-key del 592073D4
sudo apt-key del C6C83D68
