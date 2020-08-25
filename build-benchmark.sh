#!/bin/bash -eu

SCRIPT=`basename ${BASH_SOURCE[0]}`

#Help function
function HELP {
  echo -e "Usage: $SCRIPT [-l] [benchmark-name]"
  echo -e "   -l   List the names of the benchmarks only."
  echo -e "Build benchmark: $SCRIPT benchmark-name"
  exit 1
}

while getopts lh FLAG; do
    case $FLAG in
        l)
         # list benchmarks
            cd benchmarks
            ls -1d *
            cd - > /dev/null
            exit 0
        ;;
        h)
            HELP
            ;;
        \?) #unrecognized option - show help
            echo -e \\n"Option -${BOLD}$OPTARG${OFF} not allowed."
            HELP
            ;;
    esac
done

shift $((OPTIND -1))

benchmark=$1; shift 

cd benchmarks/$benchmark

docker build --target=${benchmark} -t ${benchmark}-base --build-arg nproc=`nproc` .

docker build --target=${benchmark}-patched -t ${benchmark}-patched --build-arg nproc=`nproc` .

mkdir -p build

docker run --rm -v `pwd`/build:/build --user $(id -u):$(id -g) -it ${benchmark}-base

docker run --rm -v `pwd`/build:/build --user $(id -u):$(id -g) -it ${benchmark}-patched


