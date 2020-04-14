#!/bin/bash
# 读取包含某个词的一行(该词是出现在每行的第一个词。用‘:‘和其他内容分开)，内容和行号（提示： awk，或者read）

file_name="/tmp/t1.tmp"
echo "lei:yu:is:good" > $file_name
echo "xia:yu:is:good" >> $file_name
echo "wang:yu:is:good" >> $file_name
echo "si:yu:is:good" >> $file_name
echo "liu:yu:is:good" >> $file_name
echo "kong:yu:is:good" >> $file_name

name_to_search="liu"

cat $file_name | awk -v name=$name_to_search -F':' '{if($1==name)print $0}'