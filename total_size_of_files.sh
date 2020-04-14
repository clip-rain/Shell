#!/bin/bash
#统计文件夹下所有文件的大小

ls -l $1 | awk '{size+=$5} END{print "total size of all the files is:",size}
'
