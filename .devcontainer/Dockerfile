FROM ghcr.io/illgrenoble/webx-dev-env-ubuntu:24.04

# Install dependencies
RUN apt install -y apt-utils libclang-dev libpam-dev clang

# Install webx user
RUN addgroup --system --quiet webx \
 && adduser --system --quiet --ingroup webx --no-create-home --home /nonexistent webx

# Install Rust
RUN curl https://sh.rustup.rs -sSf > /tmp/rustup-init.sh \
    && chmod +x /tmp/rustup-init.sh \
    && sh /tmp/rustup-init.sh -y \
    && rm -rf /tmp/rustup-init.sh

RUN ~/.cargo/bin/rustup default nightly

# Create standard users
RUN useradd -m -U -s /bin/bash -p $(openssl passwd -6 'mario') mario \
    && useradd -m -U -s /bin/bash -p $(openssl passwd -6 'luigi') luigi \
    && useradd -m -U -s /bin/bash -p $(openssl passwd -6 'peach') peach \
    && useradd -m -U -s /bin/bash -p $(openssl passwd -6 'toad') toad \
    && useradd -m -U -s /bin/bash -p $(openssl passwd -6 'bowser') bowser \
    && useradd -m -U -s /bin/bash -p $(openssl passwd -6 'yoshi') yoshi

# Update X config to allow creation of Xorg and xfce4 desktop manager by non-root user
RUN sed -i 's/console/anybody/g' /etc/X11/Xwrapper.config \
    && echo "needs_root_rights = no" | tee -a /etc/X11/Xwrapper.config \
    && cp /etc/X11/xrdp/xorg.conf /etc/X11/xorg.conf
