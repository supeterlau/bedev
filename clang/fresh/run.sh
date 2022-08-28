#!/usr/bin/env bash

set -x

cc -w -o $1 $1.c

echo "\nProgram Output:\n"
./$1
