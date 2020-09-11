#!/usr/bin/env bash

echo "c1 peter / c2 james / c3 fred"

name=$1
erl -sname $name@localhost -kernel shell_history enabled


