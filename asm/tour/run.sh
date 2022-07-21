#! /usr/bin/env sh

# set -x

filename=${1%.*}

nasm -f elf $1 && \
  ld -m elf_i386 -s ${filename}.o

echo ">>> Execute Result:\n\n"
./a.out

echo "\n\n>>> Clean\n"
make clean

# nasm -f macho $1 && \
#   ld -macosx_version_min 10.14 -e _start ${filename}.o -lSystem -no_pie && \
#   ./a.out
  # ld -macosx_version_min 10.14 -o taste -e _start taste.o -lSystem
