#! /usr/bin/env sh

set -x

filename=${1%.*}

nasm -f macho64 $1 && \
  ld -macosx_version_min 10.14 -e _start ${filename}.o -lSystem -no_pie && \
  ./a.out
  # ld -macosx_version_min 10.14 -o taste -e _start taste.o -lSystem
