FROM ubuntu:12.10 as display-xwindow.5619-feh-common
ARG nproc=1

RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    python \
    libtool \
    pkg-config \
    flex \
    bison \
    libx11-dev \
    libxi-dev \
    xutils-dev \
    zlib1g-dev \
    libglu1-mesa-dev


ADD display-xwindow.5619-feh/deps/zlib-1.2.5.tar.bz2 .
WORKDIR /zlib-1.2.5
RUN ./configure
RUN make -j $nproc install

ADD display-xwindow.5619-feh/deps/jpegsrc.v8b.tar.gz  /
WORKDIR /jpeg-8b
RUN ./configure
RUN make -j $nproc install

ADD display-xwindow.5619-feh/deps/libpng-1.2.50.tar.gz /
WORKDIR /libpng-1.2.50
RUN ./configure
RUN make -j $nproc install

# configure the Imag

ADD display-xwindow.5619-feh/ImageMagick-6.5.2-8.tar.gz /
WORKDIR /ImageMagick-6.5.2-8
RUN ./configure --without-perl


#############
## unpatched
FROM display-xwindow.5619-feh-common as display-xwindow.5619-feh
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /usr/local/lib/libMagickCore.so.2.0.0 /build/original/

#############
## patched
FROM display-xwindow.5619-feh-common as display-xwindow.5619-feh-patched
ARG nproc=1

WORKDIR /ImageMagick-6.5.2-8

ADD display-xwindow.5619-feh/patches /
RUN patch magick/xwindow.c /display_x_feh_xwindow5619.diff
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched) && cp /usr/local/lib/libMagickCore.so.2.0.0 /build/patched/
