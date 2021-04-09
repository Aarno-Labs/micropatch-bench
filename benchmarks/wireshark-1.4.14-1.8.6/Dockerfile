FROM ubuntu:12.10 as wireshark-1.4.14-1.8.6-common
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
    libgtk2.0-dev \
    libpcap-dev


# configure the wireshark
ADD wireshark-1.4.14-1.8.6/wireshark-1.4.14.tgz /
WORKDIR /wireshark-1.4.14

RUN ./autogen.sh
RUN ./configure

#############
## wireshark-1.4.14-1.8.6
FROM wireshark-1.4.14-1.8.6-common as wireshark-1.4.14-1.8.6
ARG nproc=1
RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/original/) && cp /usr/local/lib/libwireshark.so.0.0.1 /build/original/

#############
## wireshark-1.4.14-1.8.6-patched
FROM wireshark-1.4.14-1.8.6-common as wireshark-1.4.14-1.8.6-patched
ARG nproc=1

ADD wireshark-1.4.14-1.8.6/patches /
RUN patch /wireshark-1.4.14/epan/dissectors/packet-dcp-etsi.c /wireshark_packet-dcp-etsi.c.diff

RUN make -j $nproc
RUN make install

CMD (mkdir -p /build/patched) && cp /usr/local/lib/libwireshark.so.0.0.1 /build/patched/
