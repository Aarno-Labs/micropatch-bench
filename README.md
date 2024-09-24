# MicroPatch Bench

This repository contains real-world source micro-patching examples
from popular open-source programs.  The patches focus on security
vulnerabilities such as buffer overflows, integer overflows, command
injection, etc.

## Requirements

* [git LFS](https://git-lfs.github.com/), please install and enable before you clone
* Linux host (tested with Ubuntu 20.04)
* Docker (tested with version 19.03.8)

## Benchmark Artifacts

The benchmarks are located in the [benchmarks](./benchmarks)
directory.  Each benchmark includes a Dockerfile that will build the
binaries of the benchmark on any system that supports Docker.  Inside
of each benchmark directory is a compressed tarball of the source and
a `patch` directory that includes a `diff`-based patch on the source
code.

The Dockerfile will build the original binaries and the patched
binaries and copy them to the `build` directory under the benchmark
directory.

## Building the Benchmarks

The `build-benchmark.sh` script builds a benchmark.  Here is the usage
(it must be run from the root directory of this repo):

```
Usage: build-benchmark.sh [-l] [benchmark-name]
   -a   build arm version of benchmark (x86_64 is the default).
   -l   List the names of the benchmarks only.
Build benchmark: build-benchmark.sh benchmark-name
```

For example, to build the `cwebp-0.3.1-mtpaint` benchmark for arm you would run:
```
./build-benchmark.sh -a cwebp-0.3.1-mtpaint
```

If all goes well, you can find the original and patched binaries under the `build` folder:
```
$ ls benchmarks/cwebp-0.3.1-mtpaint/build/arm/*
benchmarks/cwebp-0.3.1-mtpaint/build/arm/original:
cwebp

benchmarks/cwebp-0.3.1-mtpaint/build/arm/patched:
cwebp
```

The `all.sh` script will build all benchmarks.  It has no arguments
and must be run from the root directory of this repo.

## Delete Docker Images

```
for i in $(ls benchmarks); do docker rmi $i-base; docker rmi $i-patched; done;
```

## To Reference

If you plan to use any of the benchmarks in a publication, please let
us know [info@aarno-labs.com](mailto:info@aarno-labs.com).  Refer to the
suite as "MicroPatch Bench".

Also, please cite this repository.  See the
[CITATION.cff](CITATION.cff) file.

## Acknowledgments

The work on collecting the programs, patches, and developing the
infrastructure to build the benchmarks was funded by the DARPA Assured
Micropatching (AMP) program, contract N6600120C4025.
