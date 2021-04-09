FROM ubuntu:14.04 as gmp-13420-13421
ARG nproc=1

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf autogen \
    libtool m4 automake1.11 texinfo

ARG src_tar=gmp-13421-src.tar.gz

ENV modified_files=""

# build 
COPY gmp-13420-13421/$src_tar .
RUN tar xvzf $src_tar

WORKDIR gmp-src

# Do some fixes on the configure and makefile
RUN sed -i s/AM_INIT_AUTOMAKE/'AM_INIT_AUTOMAKE([1.8 gnu no-dependencies])\n'/g configure.in
RUN sed -i s/AM_C_PROTOTYPES//g configure.in
RUN sed -i s/ansi2knr//g Makefile.am

RUN sh .bootstrap
RUN cat Makefile.am
RUN autoreconf -fvi
RUN mkdir -p /gmp-bin && ./configure --prefix=/gmp-bin
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original) && cp -R /gmp-bin/* /build/original

# Patched build
FROM gmp-13420-13421 as gmp-13420-13421-patched
ARG nproc=1

ADD gmp-13420-13421/patches /
RUN patch /gmp-src/mpn/generic/powm.c /mpn_generic_powm.c.diff
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched ) && cp -R /gmp-bin/* /build/patched/
