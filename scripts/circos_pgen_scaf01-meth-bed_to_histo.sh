#!/bin/bash

# Script to generate Circos histogram file from methylation bed file

# Avoids saving lines without methylation to reduce overhead when loading in to Circos

# Produces output file with the following format:

# label position position value
# e.g.:
# pg1 54 54 3.12

# Variables
meth_bed="../feature-tracks/Pf01r.bedgraph"
percent_meth_histo="../data/circos/plotting/pgen_scaf01_percent_meth_histo.txt"
species=pg

while IFS=$'\t' read -r line
do
   # Store line if percent meth is > 0
   methylated=$(echo "${line}" | awk '$4 > 0')

	 # Store percent meth value
   zero_check=$(echo "${line}" | awk '{print $4}')

	 # Pull out scaffold number and remove leading '0'
	 scaffold_num=$(echo "${methylated}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')

	 meth_position=$(echo "${methylated}" | awk '{print $2}')
	 meth_percentage=$(echo "${methylated}" | awk '{print $4}')

	 # If percent meth value is not equal (string evaluation required) to '0',
	 # then print
	 if [ "${zero_check}" != 0 ]
	   then printf "%s\n" "${species}${scaffold_num} ${meth_position} ${meth_position} ${meth_percentage}"
   fi
 done < "${meth_bed}" >> "${percent_meth_histo}"
