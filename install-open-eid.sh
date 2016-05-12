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

RIA_KEYV2="""-----BEGIN PGP PUBLIC KEY BLOCK-----
Comment: GPGTools - https://gpgtools.org

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
K2czbpReKw==
=aSyh
-----END PGP PUBLIC KEY BLOCK-----
"""

add_key() {
  # keystring=`echo "$RIA_KEY" | gpg` # XXX: can't be automated, gpg always creates files on disk
  keystring="0x592073D4 'RIA Software Signing Key <signing@ria.ee>'"
  echo "Adding key to trusted key set (apt-key add)"
  echo "$keystring"
  echo "$RIA_KEY" | sudo apt-key add -
  keystring="0xC6C83D68 'RIA Software Signing Key <signing@ria.ee>'"
  echo "$keystring"
  echo "$RIA_KEYV2" | sudo apt-key add -
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
  sudo apt-get install $1
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

# 14.04 trusty
# 14.10 utopic
# 15.04 vivid
# 15.10 wily
# 16.04 xenial

# check if Debian or Ubuntu
distro=`lsb_release -is`
release=`lsb_release -rs`
codename=`lsb_release -cs`
instpackage="open-eid"

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
        utopic|vivid)
          add_repository $codename
          instpackage="estonianidcard"
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
make_install $instpackage
echo -e "\n\nThank you for using Estonian ID card!"
