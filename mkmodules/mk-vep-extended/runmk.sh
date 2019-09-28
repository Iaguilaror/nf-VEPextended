#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.anno_dbSNP.vcf" \
| sed 's#.anno_dbSNP.vcf#.anno_dbSNP_vep.vcf#' \
| xargs mk
