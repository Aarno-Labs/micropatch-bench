FROM ubuntu:12.10 as tiff-4.0.3-display-common
ARG nproc=1

RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    python \
    libtool


ADD tiff-4.0.3.tar.gz /
WORKDIR /tiff-4.0.3
RUN ./configure

#############
## tiff-4.0.3-display-common-base
FROM tiff-4.0.3-display-common as tiff-4.0.3-display
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /tiff-4.0.3/tools/.libs/gif2tiff /build/original/

#############
## tiff-4.0.3-display-common-patched
FROM tiff-4.0.3-display-common as tiff-4.0.3-display-patched
ARG nproc=1

ADD patches /
RUN patch /tiff-4.0.3/tools/gif2tiff.c /gif2tiff_x_display_gif2tiff355.diff

RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched) && cp  /tiff-4.0.3/tools/.libs/gif2tiff /build/patched/
