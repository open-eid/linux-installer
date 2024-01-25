#!/bin/bash
# This script removes DigiDoc4 Client (open-eid) packages

# Delete open-eid and opensc (and their dependencies):
/usr/bin/sudo /usr/bin/dpkg --purge \
    awp chrome-token-signing chrome-token-signing-policy \
    firefox-pkcs11-loader libdigidoc-common libdigidoc-tools \
    libdigidoc2 libdigidocpp-common libdigidocpp-tools libdigidocpp1 \
    open-eid opensc opensc-pkcs11 qdigidoc qdigidoc-tera qdigidoc4 \
    qesteidutil token-signing-chrome token-signing-firefox token-signing-native \
    web-eid web-eid-chrome web-eid-firefox web-eid-native

# Remove ria-repository.list from /etc/apt/sources.list.d/:
/usr/bin/sudo rm /etc/apt/sources.list.d/ria-repository.list

# Remove RIA's key from the trusted key set:
/usr/bin/sudo rm /etc/apt/trusted.gpg.d/ria-repository.gpg
/usr/bin/sudo rm /usr/share/keyrings/ria-repository.gpg
/usr/bin/sudo /usr/bin/apt-key del C6C83D68
