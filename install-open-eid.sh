#!/bin/bash
# This script configures .deb based Linux repositories
# License: public domain
# Script https://github.com/open-eid/linux-installer
# See wiki https://github.com/open-eid/linux-installer/wiki/Linux-Packages
set -e

# Key used for signing releases
RIA_KEY="""-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: GPGTools - https://gpgtools.org

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
K2czbpReKw==
=aSyh
-----END PGP PUBLIC KEY BLOCK-----
"""

add_key() {
  # keystring=`echo "$RIA_KEY" | gpg` # XXX: can't be automated, gpg always creates files on disk
  keystring="0xC6C83D68 'RIA Software Signing Key <signing@ria.ee>'"
  echo "Adding key to trusted key set (apt-key add)"
  echo "$keystring"
  echo "$RIA_KEY" | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/ria-repository.gpg > /dev/null
}

test_sudo() {
  if ! command -v sudo>/dev/null; then
     make_fail "You must have sudo and be in sudo group\nAs root do: apt-get install sudo && adduser $USER sudo"
  fi
}

test_root() {
  if test $(id -u) -eq 0; then
    echo "You run this script as root. DO NOT RUN RANDOM SCRIPTS AS ROOT."
    exit 2
  fi
}

# add the given repository into /etc/apt/sources.list.d
add_repository() {
  umask 0022
  echo "Adding RIA repository to APT sources list (/etc/apt/sources.list.d/ria-repository.list)"
  echo "deb https://installer.id.ee/media/ubuntu/ $1 main" | sudo tee /etc/apt/sources.list.d/ria-repository.list
}

make_install() {
  echo "Installing software (apt-get update && apt-get install open-eid)"
  sudo apt-get update
  sudo apt-get install opensc "$@"
}

make_fail() {
  echo -e "$1"
  exit 3
}

make_warn() {
  echo "### $1"
  echo "Press ENTER to continue, CTRL-C to cancel"
  read -r dummy
}

### Install Estonian ID card software

# check for Debian derivative.
if ! command -v lsb_release>/dev/null; then
  make_fail "# Not a Debian Linux :("
fi

# we use sudo
test_root
test_sudo

# version   name    LTS   supported until
# 18.04     bionic  LTS   2023-04
# 20.04     focal   LTS   2025-04
# 21.10     impish    -   2022-07
LATEST_SUPPORTED_UBUNTU_CODENAME='impish'

# check if Debian or Ubuntu
distro=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
release=$(lsb_release -rs)
codename=$(lsb_release -cs)

case $distro in
   debian)
      make_warn "Debian is not officially supported"
      echo "### Installing possibly missing https support for APT (apt-get install apt-transport-https)"
      # Debian lacks https support for apt, by default
      sudo apt-get install apt-transport-https
      case "$codename" in
        buster)
          make_warn "Debian $codename is not officially supported"
          make_warn "Installing from ubuntu-bionic repository"
          add_repository bionic
          ;;
        *)
          make_fail "Debian $codename is not officially supported"
          ;;
      esac
      ;;
   ubuntu|neon)
      case $distro in
         neon) make_warn "Neon is not officially supported; assuming that it is equivalent to Ubuntu" ;;
         *) ;;
      esac
      case $codename in
        utopic|vivid|wily|trusty|artful|cosmic|disco|xenial|eoan|groovy|hirsute)
          make_fail "Ubuntu $codename is not officially supported"
          ;;
        bionic|focal|impish)
          add_repository $codename
          ;;
        *)
          make_warn "Ubuntu $codename is not officially supported"
          make_warn "Trying to install package for Ubuntu ${LATEST_SUPPORTED_UBUNTU_CODENAME}"
          add_repository ${LATEST_SUPPORTED_UBUNTU_CODENAME}
          ;;
      esac
      ;;
   linuxmint)
      case $release in
        20*)
          make_warn "Linuxmint 20 is not officially supported"
          add_repository focal
          ;;
        19*)
          make_warn "LinuxMint 19 is not officially supported"
          add_repository bionic
          ;;
        *)
          make_fail "LinuxMint $release is not officially supported"
          ;;
      esac
      ;;
   elementary*os|elementary)
      case $release in
        5.*)
          make_warn "Elementary OS 5 is not officially supported"
          add_repository bionic
          ;;
        *)
          make_fail "Elementary OS $release is not officially supported"
          ;;
      esac
      ;;
   pop)
      case $codename in
        artful|cosmic|disco|eoan)
          make_fail "Pop!_OS $codename is not officially supported"
          ;;
        bionic|focal)
          make_warn "Pop!_OS $codename is not officially supported"
          add_repository $codename
          ;;
        *)
          make_warn "Pop!_OS $codename is not officially supported"
          make_warn "Trying to install package for Pop!_OS ${LATEST_SUPPORTED_UBUNTU_CODENAME}"
          add_repository ${LATEST_SUPPORTED_UBUNTU_CODENAME}
          ;;
      esac
      ;;
   *)
      make_fail "$distro is not supported :("
      ;;
esac

add_key
make_install open-eid
read -p "Would you like to activate Chrome ID-card signing support automatically? (Y/n): " policy
case $policy in
    [Yy]*|"" ) sudo apt-get install web-eid-chrome-policy;;
    * ) ;;
esac
# Configure Chrome PKCS11 driver for current user, /etc/xdg/autstart/ will init other users on next logon
/usr/bin/esteid-update-nssdb
echo -e "\n\nThank you for using Estonian ID card!"
