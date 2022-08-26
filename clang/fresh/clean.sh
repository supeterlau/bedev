#!/usr/bin/env bash

find . -type f -perm +111  -not -path '**/node_modules/*' -not -path '**/.git/*' | awk '{print substr($0,3,length($0))}' | xargs rm -f
