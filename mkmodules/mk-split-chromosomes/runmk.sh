#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf" \
| sed 's#.vcf#.CHECKPOINT.tmp#' \
| xargs mk
