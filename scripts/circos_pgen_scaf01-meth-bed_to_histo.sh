#!/bin/bash


# Variables
meth_bed="../../../feature-tracks/"
percent_meth_histo="../circos/plotting"
species=pg

while IFS=$'\t' read -r line
do methylated=$(echo "${line}" | awk '$4 > 0')
   zero_check=$(echo "${line}" | awk '{print $4}')
	 scaffold_num=$(echo "${methylated}" | awk -F"[_\t]" '{print $2}' | sed 's/^0//')
	 meth_position=$(echo "${methylated}" | awk '{print $2}')
	 meth_percentage=$(echo "${methylated}" | awk '{print $4}')
	 if [ "${zero_check}" != 0 ]
	   then printf "%s\n" "${species}${scaffold_num} ${meth_position} ${meth_position} ${meth_percentage}"
   fi
 done < "${meth_bed}" >> "${percent_meth_histo}"
