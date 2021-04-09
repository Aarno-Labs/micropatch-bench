#! /bin/bash

docker build -f benchmarks/$1/Dockerfile.arm --target=$1-arm -t $1-base-arm --build-arg nproc=`nproc` benchmarks/.
