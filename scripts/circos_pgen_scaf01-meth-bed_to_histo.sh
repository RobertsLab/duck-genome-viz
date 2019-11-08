#!/bin/bash

# Script to generate Circos histogram file from methylation bed file

# Avoids saving lines without methylation to reduce overhead when loading in to Circos

# Produces output file with the following format:

# label position position value
# e.g.:
# pg1 54 54 3.12

# Variables
meth_bed="../feature-tracks/Pf01r.bedgraph"
percent_meth_histo="../circos/data/plotting/pgen_scaf01_percent_meth_histo.txt"
species=pg

# Read in individual columns (this is much faster than by line)
while IFS=$'\t' read -r scaffold start stop meth_percentage
do
   if [ "${meth_percentage}" != 0 ]
	   then
			 scaffold_num=$(echo "${scaffold}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')
			 printf "%s\n" "${species}${scaffold_num} ${start} ${start} ${meth_percentage}"
   fi
 done < "${meth_bed}" >> "${percent_meth_histo}"
