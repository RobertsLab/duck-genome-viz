#!/bin/bash

# Script to convert default bed label to Circos label


# Produces output file with the following format:

# label position position count
# e.g.:
# pg1 54 100

# Variables
bed="../data/Panopea-generosa-v1.0.a4.gene.bed"
circos_bed="../circos/data/plotting/Panopea-generosa-v1.0.a4.gene.circos.bed"
species=pg

# Read in individual columns (this is much faster than by line)
while IFS=$'\t' read -r scaffold start stop
do
  scaffold_num=$(echo "${scaffold}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')
  printf "%s\n" "${species}${scaffold_num} ${start} ${stop}"
done < "${bed}" >> "${circos_bed}"
