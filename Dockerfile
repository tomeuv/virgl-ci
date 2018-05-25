FROM debian:testing-slim

RUN echo deb-src http://deb.debian.org/debian testing main >> /etc/apt/sources.list
RUN apt-get update
RUN apt -y install ca-certificates
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt -y install git check weston linux-image-amd64 libgbm-dev openssh-server meson libxvmc-dev autoconf ccache vagrant-libvirt golang-go git ca-certificates procps linux-image-amd64 systemd dbus busybox strace
RUN DEBIAN_FRONTEND=noninteractive apt -y build-dep qemu mesa virglrenderer

RUN /usr/sbin/update-ccache-symlinks

