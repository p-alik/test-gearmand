#!/usr/bin/env bash

is_pos_int() {
  [[ ! "$1" =~ ^[0-9] ]]
}

set -o errexit -o noclobber -o nounset -o pipefail
params="$(getopt -o h:p:i:t:s:S -l host:,port:,iteration:,timeout:,start:,ssl --name "$0" -- "$@")"
eval set -- "$params"

PL_LIB="-I../perl-gearman/lib -I lib"

BN=${0##*/}
SCRIPT_NAME="${BN:4:-3}.pl"
echo $BN
echo $SCRIPT_NAME
GR_HOST="localhost"
GR_PORT=4730
ITERATION=10
SSL=
START=1000
TIMEOUT=5

while true
do
  case "$1" in
    -h|--host)
      GR_HOST=$2
      shift 2
      ;;
    -p|--port)
      if is_pos_int "$2"
      then
        echo "invalid port value: $2"
        exit 1
      fi

      GR_PORT=$2
      shift 2
      ;;
    -i|--iteration)
      if is_pos_int "$2"
      then
        echo "invalid iteration value: $2"
        exit 1
      fi

      ITERATION=$2
      shift 2
      ;;
    -t|--timeout)
      if is_pos_int "$2"
      then
        echo "invalid timeout value: $2"
        exit 1
      fi

      TIMEOUT=$2
      shift 2
      ;;
    -s|--start)
      if is_pos_int "$2"
      then
        echo "invalid start value: $2"
        exit 1
      fi

      START=$2
      shift 2
      ;;
    -S|--ssl)
      SSL="--ssl"
      shift 1
      ;;
    --)
      shift
      break
      ;;
    *)
      echo "Not implemented: $1" >&2
      exit 1
      ;;
    esac
done

if [[ "$SCRIPT_NAME" == "client.pl" ]]
then
  set -x
  perl ${PL_LIB}  bin/${SCRIPT_NAME} \
        --host=${GR_HOST} \
        --port=${GR_PORT} \
        --timeout=${TIMEOUT} \
        --iteration=${ITERATION} \
        --start=${START} \
        ${SSL}
else
  set -x
  perl ${PL_LIB}  bin/${SCRIPT_NAME} \
        --host=${GR_HOST} \
        --port=${GR_PORT} \
        --timeout=${TIMEOUT} \
        ${SSL}
fi
