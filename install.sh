#!/bin/bash

echo "Installing mergerfs apt repo updater"
if [ $EUID -ne 0 ]; then
   echo "Error: This script must be run with sudo."
   exit 1
fi

sudo cp update-mergerfs-repo /usr/local/bin
sudo chmod a+x /usr/local/bin/update-mergerfs-repo

sudo cp update-mergerfs-repo.service /etc/systemd/system/
sudo cp update-mergerfs-repo.timer /etc/systemd/system/

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable --now update-mergerfs-repo.timer

echo -e "Installation done.\n"
echo "To start the first repo update please run:"
echo "sudo systemctl start update-mergerfs-repo.service"
