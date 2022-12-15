#!/usr/bin/env bash

set -e

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
    sudo rm /etc/resolv.conf
    sudo bash -c 'echo "nameserver 8.8.8.8" > /etc/resolv.conf'
    sudo bash -c 'echo "[network]" > /etc/wsl.conf'
    sudo bash -c 'echo "generateResolvConf = false" >> /etc/wsl.conf'
    sudo chattr +i /etc/resolv.conf
fi

./bin/font install FiraMono
