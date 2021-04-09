#!/bin/bash -eu

SCRIPT=`basename ${BASH_SOURCE[0]}`

#Help function
function HELP {
  echo -e "Usage: $SCRIPT [-l] [benchmark-name]"
  echo -e "   -a   build arm version of benchmark."
  echo -e "   -l   List the names of the benchmarks only."
  echo -e "Build benchmark: $SCRIPT benchmark-name"
  exit 1
}

arm=""
arm_ext=""
arm_dir=""

while getopts lha FLAG; do
    case $FLAG in
        l)
         # list benchmarks
            cd benchmarks
            ls -1d *
            cd - > /dev/null
            exit 0
        ;;
	a)
	    arm=-arm
	    arm_ext=.arm
	    arm_dir=arm
	    break
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

cd benchmarks

target=${benchmark}$arm
tname=${benchmark}-base$arm

tpatched=${benchmark}-patched$arm
pname=${benchmark}-patched$arm

docker build -f $benchmark/Dockerfile$arm_ext --target=$target -t $tname --build-arg nproc=`nproc` .
docker build -f $benchmark/Dockerfile$arm_ext --target=$tpatched -t $pname  --build-arg nproc=`nproc` .

mkdir -p ${benchmark}/build

docker run --rm -v `pwd`/${benchmark}/build:/build --user $(id -u):$(id -g) -it $tname

docker run --rm -v `pwd`/${benchmark}/build:/build --user $(id -u):$(id -g) -it $pname


