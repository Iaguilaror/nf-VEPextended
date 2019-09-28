#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf" \
  ! -name "*.anno_dbSNP.vcf" \
| sed 's#.vcf#.anno_dbSNP.vcf#' \
| xargs mk
