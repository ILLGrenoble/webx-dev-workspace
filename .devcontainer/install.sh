#!/bin/bash

mkdir /var/log/webx
mkdir /etc/webx

# Copy session manager config files
cp webx-router/bin/pam-webx /etc/pam.d/webx
cp webx-router/bin/startwm.sh /etc/webx/startwm.sh
cp webx-router/config.example.yml webx-router/config.yml 

# Update default config
sed -i 's|/etc/X11/xrdp/xorg.conf|xorg.conf|g' webx-router/config.yml 
sed -i 's/startxfce4/dbus-launch startxfce4/g' /etc/webx/startwm.sh

