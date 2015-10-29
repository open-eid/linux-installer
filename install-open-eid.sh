#!/bin/bash
# This script configures .deb based Linux repositories
# License: public domain
# Script https://github.com/open-eid/linux-installer
# See wiki https://github.com/open-eid/linux-installer/wiki/Linux-Packages
set -e

# Key used for signing releases
RIA_KEY="""-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.9 (GNU/Linux)

mQGiBEzGeRYRBAD6h9dnYIjEWCTFdnWGLeXXTHArs4uRcN74UjrmlH230lvjjdjb
9c46k3VJZimjTyWTpe9X4lEiOqBmQ08OAG8hOihh/ro2FwgPA6lvW98dr5jiVW/G
c45eE9tWo5BigkDV8tqP5SA206644gRMLo5AjPWyY/CnjPVhQHZOzEDCLwCgxW5u
394CNteTI5dJ87fGNXxKE+UD/3KlW1CdSHLSS+V/FuW0Z2xMXz1Cvgu1FfRxGYTy
dCR4/YRCQ4HoOk54e8NnVRQj+b6JhA65Dg7ghHpt0IAmx7b7LGWOgIPJTCDZw9b3
s/RII2uWLsIttrONks+SZfBnS+f7eQcGdvGnsDWu2vNnzbkShK6qjDcYW+LUvJxF
+acvA/47ar0MsH503SFk7zJ857L2rx/YuJcPS0v8eHwnBOP/QoQtshPqrArSFYUM
fyikSPqrdFA4zSBqOoUgGMbJ0xn1/GsgQYcmE6KFOb34RLZtcmE79Yq+TXLmG/L1
eEEeBgik5jjcj1KqUMlEgJupiNbmlaBFfSklIhTRCRShdblzzbQpUklBIFNvZnR3
YXJlIFNpZ25pbmcgS2V5IDxzaWduaW5nQHJpYS5lZT6IYAQTEQIAIAUCTMZ5FgIb
AwYLCQgHAwIEFQIIAwQWAgMBAh4BAheAAAoJELM5s21ZIHPU/hcAnRYC9kn2ADv6
3oUBMQaQd5n1+oOyAJ4v62yQ58x8QHo0kLcKvIuAbD9jDrkBDQRMxnkWEAQAkw4l
St3UftG9Lo6gP1aOiumcuKadramAvRNywJZ5wvKeEtWqQG6+Ef9mifApoQtA2yEp
eTdTa7qAIyujdSIjPjxeXrSWviznLK3Thm4ylYurA3Mzom4aQM0N25RVxiQelEk1
e7tmXTgYmUcwbWkIQmkdMhHvZnPy6AXEHIQZgw8AAwUD/05ULVRazIc553F/Qghm
K1MIOUQpBjPYBFvr1MycxKIgPxDjy+e5bsPtcgc5SlXXjlKAqSYrs42Yz8o3stfv
X0qQv56PLCmmqKvKRrR09+ra/8oaQMm4DDJHzUm8SDy5A53rr/7QoUM+R9bc8QgO
dE4ZELZL8Ua3zgIiJ9lvTOrtiEkEGBECAAkFAkzGeRYCGwwACgkQszmzbVkgc9RQ
bACfeSihUW1fWwHRDkQ8QphxpaaM0SsAn1+nvmIQRuGp/NGICOtsLA544Yz2
=zJUy
-----END PGP PUBLIC KEY BLOCK-----
"""

add_key() {
  # keystring=`echo "$RIA_KEY" | gpg` # XXX: can't be automated, gpg always creates files on disk
  keystring="0x592073D4 'RIA Software Signing Key <signing@ria.ee>'"
  echo "Adding key to trusted key set (apt-key add)"
  echo "$keystring"
  echo "$RIA_KEY" | sudo apt-key add -
}

test_sudo() {
  if ! which sudo>/dev/null; then
     make_fail "You must have sudo and be in sudo group\nAs root do: apt-get install sudo && adduser $USER sudo"
  fi
}

test_root() {
  if test `id -u` -eq 0; then
    echo "You run this script as root. DO NOT RUN RANDOM SCRIPTS AS ROOT."
    exit 2
  fi
}

# add the given repository into /etc/apt/sources.list.d
add_repository() {
  echo "Adding RIA repository to APT sources list (/etc/apt/sources.list.d/ria-repository.list)"
  echo "deb https://installer.id.ee/media/ubuntu/ $1 main" | sudo tee /etc/apt/sources.list.d/ria-repository.list
}

make_install() {
  echo "Installing software (apt-get update && apt-get install open-eid)"
  sudo apt-get update
  sudo apt-get install open-eid
}

make_fail() {
  echo -e "$1"
  exit 3	
}

make_warn() {
  echo "### $1"
  echo "Press ENTER to continue, CTRL-C to cancel"
  read dummy
}

### Install Estonian ID card software

# check for Debian derivative.
if ! which lsb_release>/dev/null; then
  make_fail "# Not a Debian Linux :("
fi

# we use sudo
test_root
test_sudo

# 13.10 saucy
# 14.04 trusty
# 14.10 utopic
# 15.04 vivid

# check if Debian or Ubuntu
distro=`lsb_release -is`
release=`lsb_release -rs`
codename=`lsb_release -cs`

case $distro in
   Debian)
      make_warn "Debian is not officially supported"
      echo "### Installing possibly missing https support for APT (apt-get install apt-transport-https)"
      # Debian lacks https support for apt, by default
      sudo apt-get install apt-transport-https
      case $codename in
        wheezy)
          add_repository trusty
          ;;
        *)
          make_fail "Debian $codename is not officially supported"
          ;;
      esac
      ;;
   Ubuntu)
      case $codename in
        wily)
          make_warn "Ubuntu $codename is not officially supported"
          add_repository vivid
          ;;
        *)
          add_repository $codename
          ;;
      esac
      ;;
   LinuxMint)
      case $release in
        17*)
          make_warn "LinuxMint is not officially supported"
          add_repository trusty
          ;;
        *)
          make_fail "LinuxMint $release is not officially supported"
          ;;
      esac
      ;;
   *)
      make_fail "$distro is not supported :("
      ;;
esac

add_key
make_install
echo -e "\n\nThank you for using Estonian ID card!"
