#!/bin/bash

mkdir /var/log/webx
mkdir -p /etc/webx/webx-session-manager

# Copy session manager config files
cp webx-session-manager/bin/pam-webx /etc/pam.d/webx
cp webx-session-manager/bin/startwm.sh /etc/webx/webx-session-manager/startwm.sh
cp webx-session-manager/config.example.yml webx-session-manager/config.yml 

# Update default config
sed -i 's|/etc/X11/xrdp/xorg.conf|xorg.conf|g' webx-session-manager/config.yml 
sed -i 's/startxfce4/dbus-launch startxfce4/g' /etc/webx/webx-session-manager/startwm.sh

