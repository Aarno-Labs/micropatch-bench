FROM ubuntu:14.04 as libtiff-ee2ce5b7-b5691a5a
ARG nproc=1

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf autogen \
    libtool m4 automake

ARG src_tar=libtiff-eec7ec0-src.tar.gz

ENV modified_files="/libtiff-src/port/.libs/libport.a /libtiff-src/libtiff/.libs/libtiff.a /libtiff-src/libtiff/.libs/libtiffxx.a /libtiff-src/tools/tiff2pdf.o"

# Build dependencies
COPY deps .

RUN tar xvzf jpegsrc.v9a.tar.gz
RUN cd jpeg-9a &&\
    ./configure --prefix=/jpeg-9a-build &&\
    make -j 4 &&\
    make install

# build 
COPY $src_tar .
RUN tar xvzf $src_tar

WORKDIR libtiff-src

RUN sh autogen.sh
RUN autoreconf -fvi
RUN ./configure --disable-fast-install --with-jpeg-include-dir=/jpeg-9a-build/include --with-jpeg-lib-dir=/jpeg-9a-build/lib --disable-dependency-tracking
RUN make -j $nproc

CMD (mkdir -p /build/original/ ) && cp $modified_files /build/original/

# Patched build
FROM libtiff-ee2ce5b7-b5691a5a as libtiff-ee2ce5b7-b5691a5a-patched
ARG nproc=1

ADD patches /
RUN patch /libtiff-src/tools/tiff2pdf.c /tools_tiff2pdf.c.diff
RUN make -j $nproc

CMD (mkdir -p /build/patched) && cp $modified_files /build/patched/

