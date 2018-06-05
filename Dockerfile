FROM debian:unstable-slim

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
                   cmake \
                   spirv-headers
RUN apt -y build-dep qemu \
                     mesa \
                     virglrenderer \
                     libepoxy

RUN /usr/sbin/update-ccache-symlinks

RUN go get github.com/tomeuv/fakemachine/cmd/fakemachine
RUN go install github.com/tomeuv/fakemachine/cmd/fakemachine

COPY weston.service /usr/lib/systemd/system/.

