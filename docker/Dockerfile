##############################################################################
# keylime TPM 2.0 Dockerfile
#
# This file is for automatic test running of Keylime and rust-keylime.
# It is not recommended for use beyond testing scenarios.
##############################################################################

FROM fedora:latest
MAINTAINER Luke Hinds <lhinds@redhat.com>
LABEL version="1.0.1" description="Keylime - Bootstrapping and Maintaining Trust in the Cloud"

# environment variables
ARG BRANCH=master
ENV container docker
ENV KEYLIME_HOME ${HOME}/keylime
ENV TPM_HOME ${HOME}/swtpm2
COPY dbus-policy.conf /etc/dbus-1/system.d/

# Packaged dependencies
ENV PKGS_DEPS="automake \
cargo \
clang-devel \
dbus \
dbus-daemon \
dbus-devel \
dnf-plugins-core \
gcc \
git \
glib2-devel \
glib2-static \
gnulib \
kmod \
libselinux-python3 \
libtool \
libtpms \
make \
openssl-devel \
procps \
python3-cryptography \
python3-dbus \
python3-devel \
python3-m2crypto \
python3-pip \
python3-requests \
python3-setuptools \
python3-sqlalchemy \
python3-tornado \
python3-virtualenv \
python3-yaml \
python3-zmq \
redhat-rpm-config \
rust \
swtpm \
swtpm-tools \
tpm2-abrmd \
tpm2-tools \
tpm2-tss \
tpm2-tss-devel \
uthash-devel \
wget \
which"

RUN dnf makecache && \
  dnf -y install $PKGS_DEPS

# Devcontainer stuff from here on
RUN dnf install -y glibc-langpack-en glibc-locale-source && \
    localedef -i en_US -f UTF-8 en_US.UTF-8

COPY devcontainer-scripts/*.sh /tmp/library-scripts/

ARG INSTALL_ZSH="true"
ARG UPGRADE_PACKAGES="false"
ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN bash /tmp/library-scripts/common-redhat.sh "$INSTALL_ZSH" "$USERNAME" "$USER_UID" "$USER_GID" "$UPGRADE_PACKAGES" "$true"

# Clear DNF cache
RUN dnf clean all && \
  rm -rf /var/cache/dnf/*
