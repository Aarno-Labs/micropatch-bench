FROM i386/ubuntu:14.04 as fbc-5458-5459
ARG nproc=1

RUN sudo dpkg --add-architecture i386

RUN apt-get update && apt-get --no-install-recommends install -y \
    build-essential make curl wget rsync autoconf  \
    libncurses5-dev\
    libx11-dev\
    libxext-dev\
    libxpm-dev\
    libxrandr-dev\
    libxrender-dev\
    libgl1-mesa-dev\
    libgpm-dev\
    libffi-dev
    
ARG src_tar=fbc-5459-src.tar.gz

ENV modified_files=""

# build 
COPY $src_tar .
RUN tar xvzf $src_tar

WORKDIR /fbc-src

# Do some fixes on the configure and makefile
RUN sed -i '/ldcline += fbc.extopt.ld/c\\tldcline += " -l c "\n' fbc-src/src/compiler/fbc_linux.bas

RUN echo "CC = gcc -m32" > fbc-src/src/compiler/obj/linux/config.mk
RUN echo "TARGET_ARCH = x86" >> fbc-src/src/compiler/obj/linux/config.mk

RUN echo "CC = gcc -m32" > fbc-src/src/compiler/obj/linux/config.mk
RUN echo "TARGET_ARCH = x86" >> fbc-src/src/compiler/obj/linux/config.mk

RUN mkdir fbc-root

RUN cd fbc-src/src/compiler/obj/linux && \
    PATH=`pwd`/../../../../../fbc-bin/bin:$PATH ../../configure --disable-objinfo --prefix=`pwd`/../../../../../fbc-root && \
    cd ../../../../..
    
RUN cd fbc-src/src/rtlib/obj/linux && PATH=`pwd`/../../../../../fbc-bin/bin:$PATH ../../configure --disable-objinfo --prefix=`pwd`/../../../../../fbc-root && cd ../../../../..

RUN cd fbc-src/src/gfxlib2/obj/linux && PATH=`pwd`/../../../../../fbc-bin/bin:$PATH ../../configure --disable-objinfo --prefix=`pwd`/../../../../../fbc-root && cd ../../../../.. 

RUN sed -i 's/TARGET_X86_64/TARGET_X86/g' fbc-src/src/compiler/obj/linux/Makefile
RUN sed -i 's/HOST_X86_64/HOST_X86/g' fbc-src/src/compiler/obj/linux/Makefile
RUN sed -i 's/arch x86_64/arch 486/g' fbc-src/src/compiler/obj/linux/Makefile

RUN make 

CMD (mkdir -p /build/fbc-root) && cp -R fbc-root/* /build/fbc-root

# Patched build
FROM fbc-5458-5459 as fbc-5458-5459-patched
ARG nproc=1

ADD patches /
RUN patch fbc-src/src/rtlib/libfb_str_midassign.c /fbc-src_src_rtlib_libfb_str_midassign.c.diff
RUN make

CMD (mkdir -p /build/fbc-root-patched) && cp -R fbc-root/* /build/fbc-root-patched





