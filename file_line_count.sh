#!/bin/bash
#统计文件的行数，并打印出来
echo "使用awk统计"
awk 'BEGIN{count=0} {count++} END{print "Total count of lines is ",count}' $1
echo "使用wc统计"
#使用输入重定向，其实也可以直接用wc -l $1
wc -l < $1
