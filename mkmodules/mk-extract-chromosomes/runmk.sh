#!/usr/bin/env bash

## find every vcf.gz file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf.gz" \
| sed 's#.vcf.gz#.CHECKPOINT.tmp#' \
| xargs mk
