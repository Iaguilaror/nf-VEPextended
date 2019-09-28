#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf.gz" \
  ! -name "*.filtered.vcf.gz" \
| sed 's#.vcf.gz#.filtered.vcf.gz#' \
| xargs mk
