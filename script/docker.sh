#!/bin/bash

if [[ ! "$DOCKER" =~ ^(true|yes|on|1|TRUE|YES|ON])$ ]]; then
  exit
fi

SSH_USERNAME=${SSH_USERNAME:-vagrant}

# UBUNTU_MAJOR_VERSION=$(lsb_release -rs | cut -f1 -d .)

docker_package_install() {
    # Update your sources
    apt-get update

    # Get the latest docker package
    curl -sSL https://get.docker.com/gpg | sudo apt-key add -

    # Install Docker
    curl -sSL https://get.docker.com/ | sh

    # Enable memory and swap accounting
    sed -i 's/GRUB_CMDLINE_LINUX="debian-installer=en_US"/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
    update-grub

    # Docker package does not current configure daemon to start on boot
    # for Ubuntu 15.04 and up
    # if [[ "${UBUNTU_MAJOR_VERSION}" -gt "14" ]]; then
    # systemctl enable docker
    # fi

    # reboot
    echo "Rebooting the machine..."
    reboot
    sleep 60
}

give_docker_non_root_access() {
    # Add the docker group if it doesn't already exist
    groupadd docker

    # Add the connected "${USER}" to the docker group.
    gpasswd -a ${USER} docker
    gpasswd -a ${SSH_USERNAME} docker
}

give_docker_non_root_access
docker_package_install
