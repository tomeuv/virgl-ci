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
                   spirv-headers \
                   libsdl2-dev \
                   strace \
                   mercurial
RUN apt -y build-dep qemu \
                     mesa \
                     virglrenderer \
                     libepoxy \
                     libsdl2

RUN /usr/sbin/update-ccache-symlinks

RUN go get -v github.com/tomeuv/fakemachine/cmd/fakemachine
RUN go install -x github.com/tomeuv/fakemachine/cmd/fakemachine

# Drop this once http://hg.libsdl.org/SDL/rev/295cf9910d75 makes it into Debian
RUN hg clone http://hg.libsdl.org/SDL
RUN cd SDL && \
    ./autogen.sh && \
    ./configure  --prefix=/usr \
                 --includedir=\${prefix}/include \
                 --mandir=\${prefix}/share/man \
                 --infodir=\${prefix}/share/info \
                 --sysconfdir=/etc \
                 --localstatedir=/var \
                 --disable-silent-rules \
                 --libdir=\${prefix}/lib/x86_64-linux-gnu \
                 --libexecdir=\${prefix}/lib/x86_64-linux-gnu \
                 --disable-rpath \
                 --enable-sdl-dlopen \
                 --disable-loadso \
                 --disable-nas \
                 --disable-esd \
                 --disable-arts \
                 --disable-alsa-shared \
                 --disable-pulseaudio-shared \
                 --enable-ibus \
                 --disable-x11-shared \
                 --disable-video-directfb \
                 --enable-video-opengles \
                 --enable-video-wayland \
                 --disable-wayland-shared \
                 --disable-video-vulkan && \
    make -j$(nproc) install

COPY weston.service /usr/lib/systemd/system/.

