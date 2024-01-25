#!/bin/sh
# This script configures DigiDoc4 Client (open-eid) for .deb based Linux distributions
# License:  Public Domain
# Script:   https://github.com/open-eid/linux-installer
# Wiki:     https://github.com/open-eid/linux-installer/wiki/Linux-Packages
set -e

RIA_KEY="https://installer.id.ee/media/install-scripts/C6C83D68.pub"
SUDO="/usr/bin/sudo"

install_dependencies() {
    echo "Ensuring that wget and gpg are installed on the host (sudo apt update && sudo apt install gpg wget):"
    echo "This is required to add RIA's key to the trusted key set."
    echo

    $SUDO /usr/bin/apt-get update
    $SUDO /usr/bin/apt-get install -y gpg wget
}

add_key() {
    echo "Adding RIA's key to the trusted key set (/usr/share/keyrings/ria-repository.gpg)"
    echo

    # This is better than the old method - less of an eyesore.
    /usr/bin/wget -O- -q $RIA_KEY | /usr/bin/gpg --dearmor | $SUDO /usr/bin/tee /usr/share/keyrings/ria-repository.gpg > /dev/null
}

check_root() {
    if [ "$(/usr/bin/whoami)" != "root" ]; then
        if ! which $SUDO >/dev/null; then
            make_fail "This script requires root privileges, thus sudo must be installed on the system and the $USER must be in the sudoers group\nThis can be achieved by running the following command as root: apt install sudo && adduser $USER sudo"

        fi

    else
        # We're already root:
        SUDO=""

    fi
}

# Add the given repository into /etc/apt/sources.list.d:
add_repository() {
    umask 0022
    echo "Adding RIA's repository to APT sources list (/etc/apt/sources.list.d/ria-repository.list):"
    echo

    echo "deb [signed-by=/usr/share/keyrings/ria-repository.gpg] https://installer.id.ee/media/ubuntu/ $1 main" | $SUDO /usr/bin/tee /etc/apt/sources.list.d/ria-repository.list
    echo
}

make_install() {
    echo "Installing DigiDoc4 (sudo apt update && sudo apt install open-eid)"
    echo

    $SUDO /usr/bin/apt-get update
    $SUDO /usr/bin/apt-get install -y opensc open-eid

    echo "Enabling PCSCD service:"
    echo

    # Enable and start the service:
    $SUDO /usr/bin/systemctl enable --now pcscd.socket
}

make_fail() {
    echo "$1"
    exit 3
}

make_warn() {
    echo "### $1"
    echo "Press ENTER to continue, CTRL-C to cancel"
    read -r dummy
}

### Install Estonian ID card software
# Check for Debian derivative.
if ! command -v /usr/bin/lsb_release >/dev/null; then
    make_fail "# Not a Debian/Ubuntu/Kali Linux :("

fi

# This script requires root (via sudo):
check_root

# Install dependencies:
install_dependencies

# Version   Codename    LTS Supported Until
# 20.04     focal       LTS 2025-04
# 22.04     jammy       LTS 2027-04
# 22.10     kinetic     -   2023-07
# 23.04     lunar       -   2024-01
LATEST_SUPPORTED_UBUNTU_CODENAME='lunar'

# Gather OS info:
DISTRO=$(/usr/bin/lsb_release -is 2>/dev/null | /usr/bin/tr '[:upper:]' '[:lower:]')    # Outputs the distribution name (without "No LSB modules are available." warning) in lowercase
CODENAME=$(/usr/bin/lsb_release -cs 2>/dev/null)                                        # Outputs the codename info (without "No LSB modules are available." warning)
RELEASE=$(/usr/bin/lsb_release -rs 2>/dev/null)                                         # Outputs the release info (without "No LSB modules are available." warning)

case $DISTRO in
    debian | kali)
        # The warning is "generic" to ensure it covers both Debian and Kali:
        make_warn "$(/usr/bin/lsb_release -ds 2>/dev/null) is not officially supported!"
        echo "### Installing possibly missing https support for apt (apt install apt-transport-https)"
        echo

        # By default, Debian lacks https support for apt:
        $SUDO /usr/bin/apt-get install -y apt-transport-https

        case "$CODENAME" in
            bullseye)
                make_warn "Debian Bullseye is not officially supported!"
                make_warn "Installing from ubuntu-focal repository:"
                add_repository focal

                ;;

            bookworm)
	 	        make_warn "Debian Bookworm is not officially supported!"
	 	        make_warn "Installing from ubuntu-kinetic repository:"
	 	        add_repository kinetic

	 	        ;;

            kali-rolling)
                make_warn "$(/usr/bin/lsb_release -ds 2>/dev/null) is not officially supported!"

                # Current version of Kali (2023.4) can use the same repos as Debian Bookworm.
                make_warn "Installing from ubuntu-kinetic repository:"
                add_repository kinetic

                ;;

            *)
                make_fail "Debian $CODENAME is not officially supported!"

                ;;

        esac

        ;;

    ubuntu | neon)
        case $DISTRO in
            neon)
                make_warn "Neon is not officially supported; assuming that it is equivalent to Ubuntu."

                ;;

            *)
                ;;

        esac

        case $CODENAME in
            utopic | vivid | wily | trusty | artful | cosmic | disco | xenial | eoan | groovy | hirsute | impish | bionic)
                make_fail "Ubuntu $CODENAME is not officially supported!"

                ;;

            focal | jammy | kinetic | lunar)
                add_repository "$CODENAME"

                ;;

            *)
                make_warn "Ubuntu $CODENAME is not officially supported!"
                make_warn "Trying to install package for Ubuntu ${LATEST_SUPPORTED_UBUNTU_CODENAME}:"
                add_repository ${LATEST_SUPPORTED_UBUNTU_CODENAME}

                ;;

        esac

        ;;

    linuxmint)
        case $RELEASE in
            21*)
                make_warn "Linux Mint 21 is not officially supported!"
                make_warn "Installing from ubuntu-jammy repository:"
                add_repository jammy

                ;;

            20*)
                make_warn "Linux Mint 20 is not officially supported"
                make_warn "Installing from ubuntu-focal repository:"
                add_repository focal

                ;;

            *)
                make_fail "Linux Mint $RELEASE is not officially supported"

                ;;

        esac

        ;;

    elementary*os | elementary)
        case $RELEASE in
            7*)
                make_warn "Elementary OS 7 is not officially supported!"
                make_warn "Installing from ubuntu-jammy repository:"
                add_repository jammy

                ;;

            *)
                make_fail "Elementary OS $RELEASE is not officially supported!"

                ;;

        esac

        ;;

    pop)
        case $CODENAME in
            artful | cosmic | disco | eoan | bionic)
                make_fail "Pop!_OS $CODENAME is not officially supported!"

                ;;

            focal | jammy)
                make_warn "Pop!_OS $CODENAME is not officially supported!"

                # Can't find a good solution to run nested code-evals within the statement below.
                # But since $CODENAME is already defined in a safe manner, this shouldn't be too problematic.
                make_warn "Installing from ubuntu-$(echo $CODENAME | /usr/bin/tr '[:upper:]' '[:lower:]') repository:"
                add_repository "$CODENAME"

                ;;

            *)
                make_warn "Pop!_OS $CODENAME is not officially supported!"
                make_warn "Trying to install package for Pop!_OS ${LATEST_SUPPORTED_UBUNTU_CODENAME}:"
                add_repository ${LATEST_SUPPORTED_UBUNTU_CODENAME}

                ;;

      esac

      ;;

    *)
        make_fail "$DISTRO is not supported :("

        ;;

esac

add_key
make_install

# Configure Chrome PKCS11 driver for the current user, /etc/xdg/autstart/ will init other users' driver on next logon:
$SUDO /usr/bin/esteid-update-nssdb
echo
echo "Thank you for using your Estonian ID card!"
read -p "Would you like to read instructions on how to configure your browsers to use your ID-card? (Y/n): " instructions

case $instructions in
    [Yy]*|"" )
        /usr/bin/xdg-open "https://www.id.ee/en/article/ubuntu-id-software-installation-updating-and-removal/#removing-mozilla-firefox"

        ;;

    * )
        ;;

esac
