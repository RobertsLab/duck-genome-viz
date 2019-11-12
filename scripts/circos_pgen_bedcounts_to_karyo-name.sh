#!/bin/bash

# Script to generate Circos histogram file from bed counts file


# Produces output file with the following format:

# label position position count
# e.g.:
# pg1 54 100 3.12

# Variables
bed="../data/Panopea-generosa-v1.0.genes-per-1Mbp.txt"
circos_histo="../circos/data/plotting/pgen_genes-per-1Mbp_histo.txt"
species=pg

# Read in individual columns (this is much faster than by line)
while IFS=$'\t' read -r scaffold start stop count
do
  scaffold_num=$(echo "${scaffold}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')
  printf "%s\n" "${species}${scaffold_num} ${start} ${start} ${count}"
done < "${bed}" >> "${circos_histo}"
