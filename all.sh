#!/bin/bash -eu

# build all benchmarks using ./build-benchmark script

root_dir=$PWD

cd benchmarks
bench_dir=$PWD

for benchmark in *; do
    cd $bench_dir
    if [[ ! -d $benchmark ]]; then continue; fi

    echo "Building $benchmark"

    # need to have CWD as the root for the ./build-benchmark.sh script
    cd $root_dir
    ./build-benchmark.sh $benchmark
  
done

cd ..
