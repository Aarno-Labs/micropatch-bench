FROM ubuntu:12.10 as swfplay-swfdec_image.238-gnash-common
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
    libglib2.0-dev \
    libcairo2-dev \
    libpango1.0-dev \
    libgtk2.0-dev \
    liboil0.3-dev \
    libgstreamer0.10-dev




ADD swfdec-0.5.5.tar.gz /
WORKDIR /swfdec-0.5.5
RUN ./configure --with-audio=none --disable-soup --prefix=/swfplay


#############
## unpatched
FROM swfplay-swfdec_image.238-gnash-common as swfplay-swfdec_image.238-gnash
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp  /swfplay/lib/libswfdec-0.5.so.5.0.0 /build/original/

#############
## patched
FROM swfplay-swfdec_image.238-gnash-common as swfplay-swfdec_image.238-gnash-patched
ARG nproc=1

ADD patches /
RUN patch /swfdec-0.5.5/libswfdec/swfdec_image.c /swfplay_x_gnash_jpeg.diff
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched) && cp /swfplay/lib/libswfdec-0.5.so.5.0.0 /build/patched/
