FROM ubuntu:14.04 as libtiff-5b02179-3dfb33b
ARG nproc=1

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf autogen \
    libtool m4 automake

ARG src_tar=libtiff-2e42d63f-src.tar.gz

ENV modified_files="/libtiff-src/tools/.libs/tiffcrop /libtiff-src/tools/tiffcrop.o"

# Build dependencies
COPY libtiff-5b02179-3dfb33b/deps .

RUN tar xvzf jpegsrc.v9a.tar.gz
RUN cd jpeg-9a &&\
    ./configure --prefix=/jpeg-9a-build &&\
    make -j 4 &&\
    make install

# build 
COPY libtiff-5b02179-3dfb33b/$src_tar .
RUN tar xvzf $src_tar

WORKDIR libtiff-src

RUN sed -i '/ACLOCAL_AMFLAGS/c\ACLOCAL_AMFLAGS = -I m4\n' Makefile.am

RUN sh autogen.sh
RUN autoreconf -fvi
RUN ./configure --disable-fast-install --with-jpeg-include-dir=/jpeg-9a-build/include --with-jpeg-lib-dir=/jpeg-9a-build/lib --disable-dependency-tracking
RUN make -j $nproc

CMD (mkdir -p /build/original) && cp $modified_files /build/original

# Patched build
FROM libtiff-5b02179-3dfb33b as libtiff-5b02179-3dfb33b-patched
ARG nproc=1

ADD libtiff-5b02179-3dfb33b/patches /
RUN patch tools/tiffcrop.c /tools_tiffcrop.c.diff
RUN make -j $nproc

CMD (mkdir -p /build/patched) && cp $modified_files /build/patched

