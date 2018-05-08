FROM debian:testing-slim

RUN echo deb-src http://deb.debian.org/debian testing main >> /etc/apt/sources.list
RUN apt-get update

RUN apt-get -y install git check weston linux-image-amd64 libgbm-dev openssh-server meson libxvmc-dev autoconf ccache
RUN apt-get -y build-dep qemu mesa virglrenderer

RUN /usr/sbin/update-ccache-symlinks

RUN echo RESUME=none >> /etc/initramfs-tools/initramfs.conf
RUN printf '%s\n' 9p 9pnet 9pnet_virtio | tee -a /etc/initramfs-tools/modules
RUN update-initramfs -u

RUN echo PermitRootLogin yes | tee -a /etc/ssh/sshd_config
RUN echo PermitEmptyPasswords yes | tee -a /etc/ssh/sshd-config

