#!/usr/bin/env bash

## find every vcf file
#find: -L option to include symlinks
find -L . \
  -type f \
  -name "*.vcf" \
  ! -name "*.untangled_multiallelics.vcf" \
| sed 's#.vcf#.untangled_multiallelics.vcf#' \
| xargs mk
