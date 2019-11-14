#!/bin/bash

# Script to generate Circos histogram file from methylation bed file

# Avoids saving lines without methylation to reduce overhead when loading in to Circos

# Produces output file with the following format:

# label position position value
# e.g.:
# pg1 54 54 3.12

# Variables
meth_density="../data/Panopea-generosa-v1.0.meth75-per-1Mbp.txt"
meth_density_histo="../circos/data/plotting/pgen_meth75-per-1Mbp_histo.txt"
species=pg

# Read in individual columns (this is much faster than by line)
while IFS=$'\t' read -r scaffold start stop count
do
	scaffold_num=$(echo "${scaffold}" | awk -F"[_]" '{print $2}' | sed 's/^0//')
	printf "%s\n" "${species}${scaffold_num} ${start} ${stop} ${count}"
done < "${meth_density}" > "${meth_density_histo}"
