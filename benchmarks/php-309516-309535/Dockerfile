FROM ubuntu:14.04 as php-309516-309535
ARG nproc=1

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf2.13

ARG src_tar=php-991ba131-src.tar.gz

# Build dependencies

COPY php-309516-309535/deps .

RUN tar xvzf libxml2-2.7.2.tar.gz
RUN cd libxml2-2.7.2 &&\
    ./configure &&\
    make -j $nproc &&\
    make install

RUN tar xvzf bison-2.5.1.tar.gz
RUN cd bison-2.5.1 && \
    ./configure && \
    make -j $nproc && \
    make install
    
RUN tar xvzf flex-2.5.4a.tar.gz
RUN cd flex-2.5.4 && \
    ./configure && \
    make -j $nproc && \
    make install

RUN tar xvzf flex-2.5.39.tar.gz
RUN cd flex-2.5.39 && \
    ./configure && \
    make -j $nproc && \
    make install

RUN tar xvzf bison-2.2.tar.gz
RUN cd bison-2.2 && \
    ./configure && \
    make -j $nproc && \
    make install

COPY php-309516-309535/$src_tar .
RUN tar xvzf $src_tar

WORKDIR php-src

RUN ./buildconf --force
RUN ./configure
RUN make -j $nproc

CMD (mkdir -p /build/original) && cp /php-src/sapi/cli/php /build/php

# Patched build
FROM php-309516-309535 as php-309516-309535-patched
ARG nproc=1

ADD php-309516-309535/patches /
RUN patch ext/date/php_date.c /ext_date_php_date.c.diff
RUN make -j $nproc

CMD (mkdir -p /build/patched) && cp /php-src/sapi/cli/php /build/php-patched

