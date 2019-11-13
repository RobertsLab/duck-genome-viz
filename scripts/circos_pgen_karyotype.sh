#!/bin/bash

# Script to create karyotype file for Circos from FastA index file

# Creates output file formatted like:
# chr - pg1 Scaffold_01 1 0 89643857 chr1

# Variables
fasta_index=../data/Panopea-generosa-v1.0.fa.fai
karyo_file=../circos/data/karyotype/karyotype.pg.txt
species=pg

while IFS=$'\t' read -r name length offset linebases linewidth
do
	# Capture scaffold number and strip leading '0'
	scaffold_num=$(echo "${name}" | awk -F"[_]" '{print $2}' | sed 's/^0//')

	printf "chr - %s\n" "${species}${scaffold_num} ${name} 0 ${length} chr${scaffold_num}"
done < "${fasta_index}" > "${karyo_file}"
