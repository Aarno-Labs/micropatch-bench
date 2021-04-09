FROM ubuntu:16.04 as serveez-0.1.7-bugtraq-42560-common
ARG nproc=1

RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -y \
    build-essential \
    libtool-bin \
    texinfo \
    autoconf \
    python \
    libtool \
    pkg-config \
    xsltproc \
    bison  \
    guile-1.8-dev    


ADD serveez-0.1.7-bugtraq-42560/serveez-0.1.7.tar.gz /

# the patch on this version doesn't appear until later
ADD serveez-0.1.7-bugtraq-42560/deps/cpp-tricks.h /serveez-0.1.7/src/
ADD serveez-0.1.7-bugtraq-42560/deps/guile-baux.tgz /

ENV PATH=$PATH:/guile-baux

WORKDIR /serveez-0.1.7
# For some reason expects /missing 
RUN ln -s /serveez-0.1.7/missing /missing
RUN ./configure


#############
## unpatched
FROM serveez-0.1.7-bugtraq-42560-common as serveez-0.1.7-bugtraq-42560
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /usr/local/bin/serveez /build/original/

#############
## patched
FROM serveez-0.1.7-bugtraq-42560-common as serveez-0.1.7-bugtraq-42560-patched
ARG nproc=1

ADD serveez-0.1.7-bugtraq-42560/patches /
RUN patch  /serveez-0.1.7/src/http-server/http-core.c /http-core.c.diff

RUN make -j $nproc
RUN make install
CMD (mkdir -p /build/patched) && cp  /usr/local/bin/serveez /build/patched/

