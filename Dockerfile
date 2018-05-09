FROM debian:testing-slim

RUN echo deb-src http://deb.debian.org/debian testing main >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get -y install git check weston linux-image-amd64 libgbm-dev openssh-server meson libxvmc-dev autoconf ccache vagrant-libvirt
RUN apt-get -y build-dep qemu mesa virglrenderer

RUN /usr/sbin/update-ccache-symlinks

