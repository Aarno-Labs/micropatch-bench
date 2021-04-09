FROM ubuntu:12.10 as dillo-png.203-mtpaint-common
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


ADD dillo-png.203-mtpaint/deps/zlib-1.2.5.tar.bz2 .
WORKDIR /zlib-1.2.5
RUN ./configure
RUN make -j $nproc install

ADD dillo-png.203-mtpaint/deps/jpegsrc.v8b.tar.gz  /
WORKDIR /jpeg-8b
RUN ./configure
RUN make -j $nproc install

ADD dillo-png.203-mtpaint/deps/libpng-1.2.50.tar.gz /
WORKDIR /libpng-1.2.50
RUN ./configure
RUN make -j $nproc install

ADD dillo-png.203-mtpaint/deps/fltk-2.0.tar.gz /
WORKDIR /fltk-2.0
RUN autoconf
RUN ./configure
RUN make -j $nproc
RUN make install

# configure the dillo-2.1

ADD dillo-png.203-mtpaint/dillo-2.1.tar.bz2 /
WORKDIR /dillo-2.1
RUN ./configure


#############
## unpatched
FROM dillo-png.203-mtpaint-common as dillo-png.203-mtpaint
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /libpng-1.2.50/.libs/libpng12.so.0.50.0 /build/original/

#############
## patched
FROM dillo-png.203-mtpaint-common as dillo-png.203-mtpaint-patched
ARG nproc=1

ADD dillo-png.203-mtpaint/patches /
RUN patch /libpng-1.2.50/pngrutil.c /dillo_x_mtpaint_png203.diff
WORKDIR /libpng-1.2.50
RUN make -j $nproc
RUN make install

WORKDIR /dillo-2.1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched) && cp /libpng-1.2.50/.libs/libpng12.so.0.50.0 /build/patched/
