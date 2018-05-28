FROM debian:testing-slim

ARG DEBIAN_FRONTEND=noninteractive

ENV GOPATH=/usr/local/go
ENV PATH=$PATH:/usr/local/go/bin

RUN echo deb-src http://deb.debian.org/debian testing main >> /etc/apt/sources.list
RUN apt-get update
RUN apt -y install ca-certificates
RUN apt-get update

RUN apt -y install git \
                   check \
                   weston \
                   linux-image-amd64 \
                   libgbm-dev \
                   meson \
                   libxvmc-dev \
                   autoconf \
                   ccache \
                   golang-go \
                   git \
                   ca-certificates \
                   procps \
                   systemd \
                   dbus \
                   busybox \
                   strace
RUN apt -y build-dep qemu \
                     mesa \
                     virglrenderer \
                     libepoxy

RUN /usr/sbin/update-ccache-symlinks

RUN go get github.com/go-debos/fakemachine/cmd/fakemachine && \
    go install github.com/go-debos/fakemachine/cmd/fakemachine

