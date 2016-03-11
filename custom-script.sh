#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:

echo '
#

# deb cdrom:[Debian GNU/Linux 8.3.0 _Jessie_ - Official amd64 DVD Binary-1 20160123-19:03]/ jessie contrib main

#deb cdrom:[Debian GNU/Linux 8.3.0 _Jessie_ - Official amd64 DVD Binary-1 20160123-19:03]/ jessie contrib main

deb http://httpredir.debian.org/debian jessie main
deb-src http://httpredir.debian.org/debian jessie main

deb http://security.debian.org/ jessie/updates main contrib
deb-src http://security.debian.org/ jessie/updates main contrib

# jessie-updates, previously known as 'volatile'
deb http://httpredir.debian.org/debian jessie-updates main contrib
deb-src http://httpredir.debian.org/debian jessie-updates main contrib' > /etc/apt/sources.list

apt-get update

apt-get install -y cachefilesd

echo "Setting Timezone & Locale to KL & en_US.UTF-8"
ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
echo 'LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"' >> /etc/default/locale

echo "RUN=yes" > /etc/default/cachefilesd
