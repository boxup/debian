#!/usr/bin/env bash

set -eux

# Sample custom configuration script - add your own commands here
# to add some additional commands for your environment
#
# For example:

apt-get install -y cachefilesd


echo "Setting Timezone & Locale to KL & en_US.UTF-8"
ln -sf /usr/share/zoneinfo/Asia/Kuala_Lumpur /etc/localtime
echo 'LC_ALL="en_US.UTF-8"' >> /etc/environment
echo 'LANG="en_US.UTF-8"
LC_ALL="en_US.UTF-8"' >> /etc/default/locale

echo "RUN=yes" > /etc/default/cachefilesd
