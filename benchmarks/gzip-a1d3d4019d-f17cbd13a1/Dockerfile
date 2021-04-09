FROM ubuntu:14.04 as gzip-a1d3d4019d-f17cbd13a1
ARG nproc=1

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf autogen \
    libtool m4 automake1.11 texinfo git autopoint gettext

ARG src_tar=gzip-f17cbd13a1d0a7-src.tar.gz

ENV modified_files=""

# build 
COPY gzip-a1d3d4019d-f17cbd13a1/$src_tar .
RUN tar xvzf $src_tar

WORKDIR gzip-src

# Do some fixes on the configure and makefile
RUN sed -i s/'m4_esyscmd(\[build-aux\/git-version-gen.*'/'    1.0,\n'/g configure.ac
RUN sed -i '/perl/c\perl\t-' bootstrap.conf

RUN ./bootstrap
RUN sed -i '/_GL_WARN_ON_USE (gets/c//' lib/stdio.in.h
RUN mkdir -p /gzip-bin && ./configure --prefix /gzip-bin
RUN make -j $nproc
RUN make install

CMD mkdir -p /build/original && cp -R /gzip-bin/* /build/original

# Patched build
FROM gzip-a1d3d4019d-f17cbd13a1 as gzip-a1d3d4019d-f17cbd13a1-patched
ARG nproc=1

ADD gzip-a1d3d4019d-f17cbd13a1/patches /
RUN patch /gzip-src/gzip.c /gzip.c.diff
RUN make -j $nproc
RUN make install

CMD mkdir -p /build/patched && cp -R /gzip-bin/* /build/patched


