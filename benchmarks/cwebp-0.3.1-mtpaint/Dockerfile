FROM ubuntu:12.10 as cwebp-0.3.1-mtpaint-common
ARG nproc=1

RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    build-essential \
    autoconf \
    python \
    libtool \
    pkg-config \
    flex \
    bison


# add jpeg
ADD deps/jpegsrc.v8b.tar.gz  /
WORKDIR /jpeg-8b
RUN ./configure
RUN make -j $nproc install

# configure the libwebp
ADD libwebp-0.3.1.tar.gz /
WORKDIR /libwebp-0.3.1
RUN ./configure

#############
## unpatched
FROM cwebp-0.3.1-mtpaint-common as cwebp-0.3.1-mtpaint
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /libwebp-0.3.1/examples/.libs/cwebp /build/original/

#############
## patched
FROM cwebp-0.3.1-mtpaint-common as cwebp-0.3.1-mtpaint-patched
ARG nproc=1

ADD patches /
RUN patch examples/jpegdec.c /cwebp_x_mtpaint.diff

RUN make -j $nproc
RUN make install
CMD (mkdir -p /build/patched) && cp /libwebp-0.3.1/examples/.libs/cwebp /build/patched/

