#!/bin/bash
# 统计多个文件的行数

echo fileName        total_line
for file in "$@";
do
 awk -v f="$file" '{size=size+1} END{print f,size}' $file
done  
