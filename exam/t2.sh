#!/bin/bash
# 给每行加上行号，并打印第2-6行。

file_name="./subject.txt"

# delete the first line at first, and then delete the sixth to last line.
cat -n $file_name | sed '1d' | sed '6,$d'