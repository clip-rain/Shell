#!/bin/bash
# print the 9*9 multiplication table

for i in {0..9};
do
  for j in `seq 0 $i`;
  do
    printf '%-2s*%-2s=%-2s' $i $j $[$i*$j]
    printf '    '
done
  printf "\n"
done

