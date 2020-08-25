# MRAM Patch Benchmarks

This repository contains real-world patch examples from popular
open-source programs.  The patches focus on security vulnerabilities
such as buffer overflows, integer overflows, command injection, etc.

## Benchmark Artifacts

The benchmarks are located in the [./benchmarks](benchmarks)
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
   -l   List the names of the benchmarks only.
Build benchmark: build-benchmark.sh benchmark-name
```

The `all.sh` script will build all benchmarks.  It has no arguments
and must be run from the root directory of this repo.

## Benchmark Patch Details

We are in the progress of classifying each patched vulnerability and
the properties of the patch relating to the original program, i.e.,
modifies dataflow or control flow, exits program, etc.  We will make
this available soon.