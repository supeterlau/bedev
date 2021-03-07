#! /bin/sh
#
# run.sh
# Copyright (C) 2021 Peter Lau <superpeterlau@outlook.com>
#
# Distributed under terms of the MIT license.
#


scalac -deprecation $1
scala ${1%%.*}
