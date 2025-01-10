#!/bin/bash

# Install dependencies
apt install -y apt-utils libclang-dev libpam-dev clang

# Install webx user
addgroup --system --quiet webx
adduser --system --quiet --ingroup webx --no-create-home --home /nonexistent webx

# Install Rust
curl https://sh.rustup.rs -sSf > /tmp/rustup-init.sh \
    && chmod +x /tmp/rustup-init.sh \
    && sh /tmp/rustup-init.sh -y \
    && rm -rf /tmp/rustup-init.sh

~/.cargo/bin/rustup default nightly

mkdir /var/log/webx
mkdir -p /etc/webx/webx-session-manager

cp webx-session-manager/bin/pam-webx /etc/pam.d/webx
cp webx-session-manager/bin/startwm.sh /etc/webx/webx-session-manager/startwm.sh
cp webx-session-manager/config.example.yml webx-session-manager/config.yml 

# Update X config to allow creation of xfce4 desktop manager
sed -i 's|/etc/X11/xrdp/xorg.conf|xorg.conf|g' webx-session-manager/config.yml 
sed -i 's/startxfce4/dbus-launch startxfce4/g' /etc/webx/webx-session-manager/startwm.sh
sed -i 's/console/anybody/g' /etc/X11/Xwrapper.config
echo "needs_root_rights = no" | tee -a /etc/X11/Xwrapper.config
cp /etc/X11/xrdp/xorg.conf /etc/X11/xorg.conf

# Create users
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'mario') mario
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'luigi') luigi
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'peach') peach
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'toad') toad
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'bowser') bowser
useradd -m -U -s /bin/bash -p $(openssl passwd -6 'yoshi') yoshi

