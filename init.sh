#!/bin/env bash

if [ -z "$1" ]
then
  echo "\$1 is empty"
else
  mkdir -p $1/{tour,example,base,tutorial}
fi

