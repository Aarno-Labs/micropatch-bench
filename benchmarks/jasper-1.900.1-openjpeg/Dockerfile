FROM ubuntu:12.10 as jasper-1.900.1-openjpeg-common
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
    
ARG src_tar=jasper-1.900.1.tgz
ENV modified_files="/jasper-1.900.1/src/appl/jasper"


# Build dependencies

ADD deps/jpegsrc.v8b.tar.gz /
WORKDIR /jpeg-8b
RUN ./configure
RUN make -j $nproc 
RUN make -j $nproc install


######################
# jasper
######################
WORKDIR /
ADD jasper-1.900.1.tgz /

WORKDIR /jasper-1.900.1
RUN ./configure

#############
## unpatched
FROM jasper-1.900.1-openjpeg-common as jasper-1.900.1-openjpeg
ARG nproc=1
RUN make -j $nproc
RUN make install
CMD (mkdir -p /build/original/) && cp $modified_files /build/original/

#############
## patched
FROM jasper-1.900.1-openjpeg-common as jasper-1.900.1-openjpeg-patched
ARG nproc=1

WORKDIR /jasper-1.900.1
ADD patches/jasper_jpc_dec.c.diff /
RUN patch /jasper-1.900.1/src/libjasper/jpc/jpc_dec.c /jasper_jpc_dec.c.diff
RUN make -j $nproc
RUN make install
CMD (mkdir -p /build/patched) && cp $modified_files /build/patched/
