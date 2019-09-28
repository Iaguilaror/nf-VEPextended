#!/bin/bash

find -L . \
  -type f \
  -name "*.subsampled*.vcf" \
| sed "s#.subsampled.*.untangled_multiallelics.#.untangled_multiallelics.#" \
| sort -u \
| sed "s#.vcf#.vcf.gz#" \
| xargs mk
